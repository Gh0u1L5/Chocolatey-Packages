$ErrorActionPreference = 'Stop';

$url         = 'https://gethstore.blob.core.windows.net/builds/geth-windows-amd64-1.13.2-dc34fe82.exe'
$packageArgs = @{
  softwareName  = 'Ethereum*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '1cbcb841a8fee87e4cdb03fd50b76f74'
  checksumType  = 'md5'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
