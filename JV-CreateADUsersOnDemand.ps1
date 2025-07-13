# Justin Verstijnen Create Active Directory Users On Demand script
# Github page: https://github.com/JustinVerstijnen/JV-CreateADUsersOnDemand
# Let's start!
Write-Host "Script made by..." -ForegroundColor DarkCyan
Write-Host "     _           _   _        __     __            _   _  _                  
    | |_   _ ___| |_(_)_ __   \ \   / /__ _ __ ___| |_(_)(_)_ __   ___ _ __  
 _  | | | | / __| __| | '_ \   \ \ / / _ \ '__/ __| __| || | '_ \ / _ \ '_ \ 
| |_| | |_| \__ \ |_| | | | |   \ V /  __/ |  \__ \ |_| || | | | |  __/ | | |
 \___/ \__,_|___/\__|_|_| |_|    \_/ \___|_|  |___/\__|_|/ |_| |_|\___|_| |_|
                                                       |__/                  " -ForegroundColor DarkCyan
                                                       
# === PARAMETERS ===
$OU = "OU=Users_JV,DC=justinverstijnen,DC=nl"
# === END PARAMETERS ===


# Step 1: Importing the right modules
Import-Module activedirectory


# Step 2: Ask the right settings for the new user
$Firstname = Read-Host "Fill in the desired firstname..."
$Lastname = Read-Host "Fill in the desired surname..."
$Username = Read-Host "Fill in the desired username..."
$Password = Read-Host "Fill in the desired and secure password..."
$department = Read-Host "Fill in the department..."


# Step 3: Check if the user already exists and creates the user
if (Get-ADUser -F {SamAccountName -eq $Username})
       {
             #If user does exist, give a warning
             Write-Warning "A user account with username $Username already exist in Active Directory."
       }
       else
       { New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@justinverstijnen.nl" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Firstname $Lastname" `
            -Path $OU `
            -City "Mountain View" `
            -Company "Justin Verstijnen Inc." `
            -State Gelderland `
            -StreetAddress "Example street 123" `
            -OfficePhone "012345678910" `
            -EmailAddress "$Username@justinverstijnen.nl" `
            -Department $department `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $True `
            -OtherAttributes @{'proxyAddresses'= ("SMTP:$Username@justinverstijnen.nl")}
        }


# Step 4: Printing the results for the user
Write-Host "========================================================"
Write-Host "The account has been created:"
Write-Host
Write-Host "Firstname:                  $Firstname"
Write-Host "Lastname:                   $Lastname"
Write-Host "Display name:               $Firstname $Lastname"
Write-Host "Username:                   $Username"
Write-Host "Organizational Unit:        $OU"
Write-Host
Start-Sleep -Seconds 10
