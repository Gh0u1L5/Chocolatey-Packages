$ErrorActionPreference = 'Stop';

$url         = 'https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-1.17.6-3d84c6b2.exe'
$packageArgs = @{
  softwareName  = 'Ethereum*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '250cfeb290f8418672bc946f96bec8ff'
  checksumType  = 'md5'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
