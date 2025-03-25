#Script to get all computers and their OS from AD and save to a csv file
#Author: Lucas Kowe

#Import the Active Directory module
Import-Module ActiveDirectory

try {
    #Get all computers from AD
    $computers = Get-ADComputer -Filter * -Properties *
} catch {
    Write-Error "Failed to retrieve computers from Active Directory: $_"
    exit 1
}

#Create an empty array to store the computer names and OS
$computerOS = @()

#Loop through all computers
foreach ($computer in $computers) {
    try {
        #Get the computer name
        $computerName = $computer.Name
        #Get the OS
        $OS = $computer.OperatingSystem
        #Print the computer name and OS to the host
        Write-Host "Computer: $computerName, OS: $OS"
        #Add the computer name and OS to the array
        $computerOS += New-Object PSObject -Property @{
            ComputerName = $computerName
            OS = $OS
        }
    } catch {
        Write-Error "Failed to process computer $($computer.Name): $_"
    }
}

try {
    #Save the computer names and OS to a csv file
    $computerOS | Export-Csv -Path C:\temp\ComputersAndOS.csv -NoTypeInformation
} catch {
    Write-Error "Failed to export data to CSV: $_"
    exit 1
}
