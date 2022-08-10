#!/usr/bin/env python3
import backoff
import base64
import hashlib
import requests
import sys
from lxml import etree

from typing import Tuple

SPEC_PATH = 'package/spec.nuspec'
INSTALLER_PATH = 'package/tools/chocolateyInstall.ps1'


###############################################################################
# Common functions
###############################################################################

@backoff.on_exception(backoff.expo, requests.exceptions.RequestException, max_tries=3)
def read_online_file_checksum(url: str) -> str:
    m = hashlib.sha256()
    r = requests.get(url, stream=True)
    if r.status_code != 200:
        raise Exception(f'Failed to download {url}')
    for chunk in r.iter_content(chunk_size=1024):
        if chunk:
            m.update(chunk)
    return m.hexdigest()

def read_current_version() -> str:
    with open(SPEC_PATH, 'r') as f:
        for line in f:
            if line.strip().startswith('<version>'):
                return line.split('>')[1].split('<')[0]
    raise Exception(f'Failed to read version from {SPEC_PATH}')

def update_version(version: str):
    with open(SPEC_PATH, 'r') as f:
        lines = f.readlines()
    with open(SPEC_PATH, 'w') as f:
        for line in lines:
            if line.strip().startswith('<version>'):
                line = line.split('<version>')[0] + f'<version>{version}</version>\n'
            f.write(line)

def update_installer_url(url: str):
    with open(INSTALLER_PATH, 'r') as f:
        lines = f.readlines()
    with open(INSTALLER_PATH, 'w') as f:
        for line in lines:
            if line.strip().startswith('$url '):
                line = line.split("'")[0] + f"'{url}'\n"
            f.write(line)

def update_installer_checksum(checksum: str):
    with open(INSTALLER_PATH, 'r') as f:
        lines = f.readlines()
    with open(INSTALLER_PATH, 'w') as f:
        for line in lines:
            if line.strip().startswith('checksum '):
                line = line.split("'")[0] + f"'{checksum}'\n"
            f.write(line)

###############################################################################
# Specific Functions
###############################################################################

@backoff.on_exception(backoff.expo, requests.exceptions.RequestException, max_tries=3)
def check_latest_version() -> Tuple[str, str, str]:
    # Get the latest version.
    r = requests.get('https://api.github.com/repos/ethereum/go-ethereum/releases/latest')
    if r.status_code != 200:
        raise Exception(f'Failed to check latest version from github.')

    latest_version = r.json()['tag_name']
    if latest_version.startswith('v'):
        latest_version = latest_version[1:]

    # Get the download url and checksum.
    r = requests.get('https://gethstore.blob.core.windows.net/builds?restype=container&comp=list&prefix=geth-windows-amd64-')
    if r.status_code != 200:
        raise Exception(f'Failed to check metadata from gethstore.')

    root = etree.XML(r.content)
    for blob in root.find('Blobs').iter('Blob'):
        file = blob.find('Name').text
        if file.startswith('geth-windows-amd64-' + latest_version) and file.endswith('.exe'):
            if 'unstable' not in file:
                url = 'https://gethstore.blob.core.windows.net/builds/' + file
                checksum = blob.find('Properties/Content-MD5').text
                checksum = base64.b64decode(checksum).hex()
                return latest_version, url, checksum
    raise Exception(f'Failed to find latest version in gethstore.')


###############################################################################
# Main
###############################################################################

if __name__ == '__main__':
    try:
        current_version = read_current_version()
        latest_version, latest_url, checksum = check_latest_version()
        if current_version != latest_version:
            print(f'[+] Bump version from {current_version} to {latest_version}')
            update_version(latest_version)
            update_installer_url(latest_url)
            update_installer_checksum(checksum)
    except Exception as err:
        print(f'[!] Failed to check update: {err}')
        sys.exit(1)
