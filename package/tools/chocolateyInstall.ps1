$ErrorActionPreference = 'Stop';

$url         = 'https://download.bitcomet.com/achive/BitComet_1.94_setup.exe'
$packageArgs = @{
  softwareName  = 'BitComet*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '0a36cccb8c023f0ac0d829d3c616502e4889675f66921efdd0cf985bc0ab694a'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
