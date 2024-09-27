# Install Script Windows VM in Azure
# What every you do below goes to the Azure Snapshot

$ErrorActionPreference = 'Stop'

try {
  Write-Host "Starting with installation script"
  
  
  ### Retrieval credentials
  $credentials = Get-Content -Path C:\Windows\Temp\dpl_tmp\credentials.txt | ConvertFrom-Json
  
  
  ### EXAMPLE: Credentials handling 
  ##Credential by index
  write-host $($credentials[0].password)
  
  ##Username by index
  write-host $($credentials[0].username)
  
  ##Credential by username
  write-host $credentials.Where({$_.username -like "customuser1"}).password
  
  
  ###CUSTOM INSTALL LOGIC ###

  Write-Host "Finished with installation script"
}
catch{
  Write-Host $_
  exit 1
}