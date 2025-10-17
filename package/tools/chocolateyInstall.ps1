$ErrorActionPreference = 'Stop';

$url         = 'https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-1.16.5-737ffd1b.exe'
$packageArgs = @{
  softwareName  = 'Ethereum*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '538ab5f0c03a2974ac7e987b298415da'
  checksumType  = 'md5'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
