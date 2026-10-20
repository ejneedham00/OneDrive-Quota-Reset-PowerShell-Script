# Connect to SharePoint Online
Connect-SPOService -Url https://DOMAIN-admin.sharepoint.com

# Import the CSV file
$users = Import-Csv -Path "C:\QuotaResetUserList.csv"

# Loop through each user in the CSV
foreach ($user in $users) {
    # Use the OneDrive URL from the CSV file
    $OneDriveUrl = $user.OneDriveURL

    # Reset the storage quota for the user's OneDrive
    Set-SPOSite -Identity $OneDriveURL -StorageQuotaReset
}
