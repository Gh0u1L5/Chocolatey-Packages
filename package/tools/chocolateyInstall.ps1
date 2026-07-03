$ErrorActionPreference = 'Stop';

$url         = 'https://download.bitcomet.com/achive/BitComet_2.21_setup.exe'
$packageArgs = @{
  softwareName  = 'BitComet*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '2bb0ac769fe8b75b1b1b8ca42fa55d29d94aaf68480611538dbb4395d05082d2'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
