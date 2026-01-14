$ErrorActionPreference = 'Stop';

$url         = 'https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-1.16.8-abeb78c6.exe'
$packageArgs = @{
  softwareName  = 'Ethereum*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '567ae7d03565001f65207999de8f9761'
  checksumType  = 'md5'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
