$ErrorActionPreference = 'Stop';

$url         = 'https://download.bitcomet.com/achive/BitComet_2.18_setup.exe'
$packageArgs = @{
  softwareName  = 'BitComet*'
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  checksum      = '8ca4edfe5fc67b21a03c249b918bd18e320dd3df1fd42b1994bc24af3891156e'
  checksumType  = 'sha256'

  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
