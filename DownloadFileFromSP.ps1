#load sharepoint Libraries can be downloaded from https://www.microsoft.com/en-us/download/details.aspx?id=42038

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")

 

$UserName = <Email Address>   

$Password = <Password>

 #full path to sharepoint library with file name
$FileUrl = "https://customer.sharepoint.com/sites/test.xlsx"    

#Directory where file need to be downloaded
$DownloadPath =  "c:\test" 

#Name of the file with Absolute path
$fileName = "C:\test\test.xlsx"

 


    if([string]::IsNullOrEmpty($Password)) {

      $SecurePassword = Read-Host -Prompt "Enter the password" -AsSecureString

    }

    else {

      $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force

    }

    $fileName = [System.IO.Path]::GetFileName($FileUrl)

    $downloadFilePath = [System.IO.Path]::Combine($DownloadPath,$fileName)

 
 

    $client = New-Object System.Net.WebClient

    $client.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $SecurePassword)

    $client.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")

    $client.DownloadFile($FileUrl, $downloadFilePath)

    $client.Dispose()