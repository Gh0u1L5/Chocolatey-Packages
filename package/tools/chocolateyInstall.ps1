$ErrorActionPreference = 'Stop';

$url         = 'https://download.bitcomet.com/achive/BitComet_2.19_setup.exe'
$packageArgs = @{
  softwareName  = 'BitComet*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '5454eca1bc17359e2c4ae088134d95fb465c60500f4bde3114277bcb7b77f7bb'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
