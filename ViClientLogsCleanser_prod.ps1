""
""

# usual disclaimer

write-host -ForegroundColor Red "###### USUAL DISCLAIMER #####"
write-host -ForegroundColor Red "###### Use at your own risk #####"
write-host -ForegroundColor Red "###### Works with Windows with Powershell v3+ #####"
write-host -ForegroundColor Red "###### Windows 2008 and Window 7 example: C:\Users\user_name\Local Settings\AppData\Local\VMware\vpx\viclient-x.log #####"
write-host -ForegroundColor Red "###### Run As user with Admin priv #####"
write-host -ForegroundColor Red "###### CONTACT ernstgv@gmail.com for any concern #####"


""

# setting up exluded users

$exclusion = @("Public",".NET v4.5",".NET v4.5 Classic","Administrator","ADD MORE HERE AS NEEDED")


""

# Importing the list of users

$list = @(get-childitem c:\users | Where { $exclusion -notcontains $_.Name } | select -expandproperty name)



# Deleting viclient logs 


ForEach ($uname in $list) {

#### Delete all Files in C:\temp older than 30 day(s)



$viclientpath = "C:\Users\$uname\AppData\Local\VMware\vpx"
$LogAge = "-30"

$CurrentDate = Get-Date
$LogAgetoDelete = $CurrentDate.AddDays($LogAge)
write-host -ForegroundColor DarkGreen  "Deleting viclient logs for $uname" 
""


Get-ChildItem $viclientpath -ErrorAction SilentlyContinue | Where-Object { ($_.LastWriteTime -lt $LogAgetoDelete) -and ($_.name -like "viclient*.log")  } | remove-item


}


####### Ending and cleanup part ############
""



write-host -foreground darkgreen "############### Done #############"

