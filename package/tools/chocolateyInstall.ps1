$ErrorActionPreference = 'Stop';

$url         = 'PLACEHOLDER';
$packageArgs = @{
  softwareName  = 'PLACEHOLDER',
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = 'PLACEHOLDER'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
