# Initial Script that will run after booting an Azure topology from Snapshot
# Initial Script shall deploy the flags and prepare the VM per user

$ErrorActionPreference = 'Stop'
try {
    Write-Host "Starting with post installation script"
    
    ### Retrieval credentials and Multiflags
    $multiflags = Get-Content -Path C:\Windows\Temp\dpl_tmp\multiflags.txt | ConvertFrom-Json
    $credentials = Get-Content -Path C:\Windows\Temp\dpl_tmp\credentials.txt | ConvertFrom-Json
    
    ### EXAMPLE: Flag handling 
    ##Flag by index
    write-host $($multiflags[0].flag)
    ##Flag by name
    write-host $multiflags.Where({$_.Name -like "flag name 1"}).flag
    
    
    ### EXAMPLE: Credentials handling 
    ##Credential by index
    write-host $($credentials[0].password)
    
    ##Username by index
    write-host $($credentials[0].username)
    
    ##Credential by username
    write-host $credentials.Where({$_.username -like "customuser1"}).password
    
    
    ### CLEANUP Files
    Remove-Item -Recurse -Force C:\Windows\temp\dpl_tmp\*
    

    ###CUSTOM INSTALL LOGIC ###

    ### Cleanup Artifacts
    ##Clear event logs
    $logs = Get-EventLog -List -ErrorAction Ignore | ForEach-Object {$_.Log}
    $logs | ForEach-Object {Clear-EventLog  -LogName $_ -Confirm:$false -ErrorAction Ignore}
    
    ## Clear Powershell history
    Clear-History -Confirm:$false
    if ((Get-PSReadlineOption).HistorySavePath){
        Remove-Item -Force -Path (Get-PSReadlineOption).HistorySavePath -ErrorAction Ignore
    }
    
    
    Write-Host "Finished post installation script"
}
catch{
  Write-Host $_
  exit 1
}
