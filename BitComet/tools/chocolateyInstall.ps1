$ErrorActionPreference = 'Stop';

$url        = 'https://download.bitcomet.com/achive/BitComet_1.79_setup.exe'
$packageArgs = @{
  softwareName  = 'BitComet*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '6860cdfd193b7f483375c2e2a70e1e3ec6601d917e29fb37fb5d8e7539722008'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
