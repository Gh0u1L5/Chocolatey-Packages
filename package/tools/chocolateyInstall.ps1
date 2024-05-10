$ErrorActionPreference = 'Stop';

$url         = 'https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-1.14.3-ab48ba42.exe'
$packageArgs = @{
  softwareName  = 'Ethereum*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '29eadff60633f4cada4000f21e5870e1'
  checksumType  = 'md5'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
