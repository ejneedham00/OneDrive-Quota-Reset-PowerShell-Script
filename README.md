<h1>Reset the OneDrive Storage Quota for a List of Users</h1>

<h2>What it does</h2>

<p>This script is for resetting the storage quota on a batch of OneDrive sites back to the tenant default. You give it a CSV of OneDrive URLs, and it goes through each one and clears any custom quota that was set. Unlike many of my other scripts, this script is <b>NOT READ ONLY</b> and will actually make changes using a <code>SET</code> command.</p>

<h2>How it works</h2>

<ol>
  <li>Connects to SharePoint Online with <code>Connect-SPOService</code>, using the admin centre URL. <code>DOMAIN</code> needs replacing with your tenant name, and you'll get an interactive sign-in.</li>
  <li>Reads <code>C:\QuotaResetUserList.csv</code> into <code>$users</code> with <code>Import-Csv</code>. The CSV needs a column headed <code>OneDriveURL</code>.</li>
  <li>Loops through each row and stores that row's OneDrive URL in <code>$OneDriveUrl</code>.</li>
  <li>Runs <code>Set-SPOSite</code> with <code>-StorageQuotaReset</code> against that site. This removes any custom storage quota on the OneDrive, so it goes back to the default quota for the tenant.</li>
  <li>Moves on to the next row. Nothing is printed, so there is no summary or confirmation.</li>
</ol>

<h2>Prerequisites</h2>

<ul>
  <li>The SharePoint Online Management Shell module (<code>Microsoft.Online.SharePoint.PowerShell</code>)</li>
  <li>An account with the SharePoint Administrator or Global Administrator role</li>
  <li>A CSV at the path shown, with a <code>OneDriveURL</code> column containing full OneDrive URLs</li>
</ul>

<h2>Notes / Limitations</h2>

<ul>
  <li><b>Placeholder needs replacing.</b> <code>DOMAIN</code> in the admin URL must be changed to your tenant name before it will connect.</li>
  <li><b>This is the working version of the previous script.</b> The URL is passed correctly here as <code>-Identity $OneDriveURL</code>, with no single quotes around the variable.</li>
  <li>It resets to the <b>tenant default</b>, not to a value you choose. If you want to set a specific quota instead, use <code>-StorageQuota</code> with a size in MB.</li>
  <li>Resetting doesn't delete any data, but if a user is currently over the default quota, they may end up over their limit and be blocked from adding files.</li>
  <li>There is no error handling or logging. If a URL is wrong or a site is missing, you'll only see red errors in the console, with no record of which rows succeeded.</li>
  <li>There is no confirmation or <code>-WhatIf</code> step, so test it on one or two sites first, and check the CSV for blank rows or stray spaces.</li>
  <li>A CSV with a different column name, such as <code>OneDriveUrl</code> or <code>URL</code>, makes <code>$user.OneDriveURL</code> come back empty. PowerShell's property matching ignores case, but not the name itself.</li>
</ul>
