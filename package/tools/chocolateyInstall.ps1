$ErrorActionPreference = 'Stop';

$url         = 'https://download.bitcomet.com/achive/BitComet_1.93_setup.exe'
$packageArgs = @{
  softwareName  = 'BitComet*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = 'dcb7ea59b557276b6ce80bd03e5c5996648f3af8ca9b83f8ea7202b3b82f7232'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
