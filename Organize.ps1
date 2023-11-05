
<#
Open Source Script Usage and Attribution Terms
This script is open source, and all rights are reserved by the author.
Copyright (c) 2020 Safwan Shaib. All rights reserved.

Usage, modification, and distribution are allowed under the following terms:
- You may use and modify the script for personal or educational purposes.
- You may not distribute the script in a manner that implies it is your own work.
- Attribution to the original author is required if you distribute or use the script in another project.
- For any other uses, please contact the author for permission.

Date: December 14, 2020
Author: Safwan Shaib
Email: shaib.safwan@gmail.com
Description: This script organizes the downloads folder in default, or another folder of the user's choice
#>


#Elevate priviliges to run the script in admin mode
#if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


Write-Host "`n`t`t`t`t`t`t`t`t`tWelcome to:`tORGANIZE"  -ForegroundColor Yellow -BackgroundColor Magenta
Write-Host "`n`nDescription: This program organizes the downloads folder in default or a folder of your choice
Author: Safwan Shaib
Email: shaib.safwan@gmail.com`n" -ForegroundColor Yellow 
Write-Host "`nUsage & Instructions:`n
- No deletion of any file or folder will occure using this tool. however, using it Inappropriately may produce unexpected results.`n
- To exit anytime click CTRL+C (Only if necessary).`n
- Follow on-screen prompts until the end.`n
- At the end, you'll have an option to undo the changes made by the program." -ForegroundColor Magenta 

Write-Host "`n`n`n`n`n`t`t`tYour Downloads folder is set to be organized in default, do you want to organize your Downloads folder?`n
`t`t`tType 'Yes' to continue or 'No' to enter a path of the folder you want to organize`n`n"

$continueLoop = $true
while ($continueLoop) {
    $ConfirmPath = Read-Host "Type here"

    switch ($ConfirmPath) {
        "yes" {
            $path = $home + '\downloads'
            Write-Output "`n`n`t`t`t`t`tHi, I'm your junk file. Delete me or don't.`n`nThis text file saves the old order of your folder in case you want it back. If you delete it, you won't be able to restore your folder's old state.`nHowever, you can still create a new one with the file names you want back.`n`nFeel free to edit this file for including/excluding the files you want back.`n`nNote: Deleting a file's name from this file doesn't delete the file but prevents it from being restored to the main folder.`n`n" >> "$path\Old Order.txt"
            (Get-ChildItem -File -Name $path)  >> "$path\Old Order.txt" ## Save the status of the destination folder to undo the changes 
            $continueLoop = $false
			break
        }
        "no" {
            Write-Host "`nEnter the folder location (e.g.," -NoNewline
			Write-Host "C:\Users\username\documents" -ForegroundColor Cyan -NoNewline
			Write-Host "):"
			Write-Host "Hint: You can copy the path from File Explorer and paste by a mouse right-click.`n" -ForegroundColor Yellow

            $path = Read-Host "Type here"
            try {
                Resolve-Path -Path $path -ErrorAction Stop
            }
            catch {
                while (-not (Resolve-Path -Path $path)) {
                    Write-Warning "Please enter a valid path"
                    $path = Read-Host "`nTry again"
                }
            }
            
            Write-Output "`n`n`t`t`t`t`tHi, I'm your junk file. Delete me or don't.`n`nThis text file saves the old order of your folder in case you want it back. If you delete it, you won't be able to restore your folder's old state.`nHowever, you can still create a new one with the file names you want back.`n`nFeel free to edit this file for including/excluding the files you want back.`n`nNote: Deleting a file's name from this file doesn't delete the file but prevents it from being restored to the main folder.`n`n" >> "$path\Old Order.txt"
            (Get-ChildItem -File -Name $path)  >> "$path\Old Order.txt" ## Save the status of the destination folder to undo the changes
            $continueLoop = $false
			break
        }
        Default {
            Write-host "`t`t`t`Hmmm, I didn't understand that, are you in a hurry?"
            Read-Host "`n`t`t`tHit Enter and try again"
        }
    }
}


    
Set-Location $path

## Check if the direction folder has any of the folloing type of files
if ((Get-ChildItem  *.txt, *.doc*, *.xls*, *.ppt*, *.pps*, *pdf, *.epub, *.zip, *.rar, *.jpeg, *.jpg, *.png, *.gif, *.tiff, *.exe, *.msi, *.WEBM, *.ogg, *.MP4, *.m4v, *.avi, *.wmv, *.mov, *.flv, *.swf, *.avchd, *.mp3, *.wav, *.wma, *.dcd, *.alac, `
            *.acc, *.flac, *.aiff, *.bmp) -or (Get-ChildItem .\Documents (Get-ChildItem *.txt, *.doc*, *.xls*, *.ppt*, *.pps*, *pdf, *.epub, *.zip, *.rar, *.jpeg, *.jpg, *.png, *.gif, *.tiff, *.exe, *.msi, *.WEBM, *.ogg, *.MP4, *.m4v, *.avi, *.wmv, *.mov, *.flv, *.swf, *.avchd, *.mp3, *.wav, *.wma, *.dcd, *.alac, *.acc, *.flac, *.aiff, *.bmp))) {
    ##check for office files
    if ((Get-ChildItem *.txt, *.srt, *.asm, *.doc*, *.xls*, *.ppt*, *.pps*, *.pdf, *.epub ) -or ( Get-ChildItem .\Documents (Get-ChildItem *.txt, *.srt, *.asm, *.doc*, *.xls*, *.ppt*, *.pps*, *.pdf, *.epub))) {
        $check = ("yes", "no") ## check if the user types yes or no for organizing the documents folder
        Write-Host "`t`t`tDo you want to organize the Documents folder in folders as well?`n`n`n`t`t`tType 'No' to place all the documents together inside the Documents folder`n`n`t`t`tType 'Yes' to organize the Documents folder into subfolders`n"
        $OrgDoc = Read-Host "Type here"
        while (-not ($check -contains $OrgDoc )) {
            Write-Warning "Please type 'Yes' or 'No'`n`n"
            Write-Host "`t`t`tDo you want to organize the Documents folder in folders as well?`n`n`n`t`t`tType 'No' to place all the documents together inside the Documents folder`n`n`t`t`tType 'Yes' to organize the Documents folder into subfolders`n"
            $OrgDoc = Read-Host "Type here"
        }
        switch ($OrgDoc) {
            "yes" {
                ##check if you already have the Documents folder
                if (Get-ChildItem -Filter Documents) {
                    ##check for the word files
                    if ((Get-ChildItem  *.doc*) -or (Get-ChildItem .\documents *.doc*)) {
                        ##test if there already is a Word folder and move the files
                        if (Get-ChildItem -Filter .\Documents\Word) { 
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.doc*' } | Move-Item -Destination $path\Documents\Word
                        }
                        ##if not create one and move
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Word
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.doc*' } | Move-Item -Destination $path\Documents\Word
                        }
                        try {
                            if ($null -eq $found) { 
                                Safwan  ## produce an error to do the catch block
                            } 
                        }
                        catch {
                            Get-ChildItem  | Where-Object { $_.Name -like '*.doc*' } | Move-Item -Destination $path\Documents\Word
                        }
                    }
                    ## Check for the Excel files
                    if ((Get-ChildItem  *.xls*) -or (Get-ChildItem .\documents *.xls*)) {
                        ## Test if there is already an excel folder and move the files
                        if (Get-ChildItem -Filter .\Documents\Excel) { 
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.xls*' } | Move-Item -Destination $path\Documents\Excel
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Excel
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.xls*' } | Move-Item -Destination $path\Documents\Excel
                        }
                        try {
                            if ($null -eq $found) {
                                Safwan  ## produce an error to do the catch block 
                            }
                        }
                        catch {
                            Get-ChildItem  | Where-Object { $_.Name -like '*.xls*' } | Move-Item -Destination $path\Documents\Excel
                        }
                    }
                    ## Check for the Presentation files
                    if ((Get-ChildItem  *.ppt*, *.pps*) -or (Get-ChildItem .\Documents (Get-ChildItem *.ppt*, *.pps*) )) {
                        ## Test if there is already a presentation folder, move the files into it
                        if (Get-ChildItem -Filter .\Documents\Presentation) {
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.ppt*' -or $_.name -like '*.pps*' } | Move-Item -Destination $path\Documents\Presentation
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Presentation
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.ppt*' -or $_.name -like '*.pps*' } | Move-Item -Destination $path\Documents\Presentation
                        } 
                        try {
                            if ($null -eq $found) { 
                                Safwan  ## produce an error to do the catch block
                            }
                        }
                        catch {
                            Get-ChildItem  | Where-Object { $_.Name -like '*.ppt*' -or $_.name -like '*.pps*' } | Move-Item -Destination $path\Documents\Presentation 

                        }
                        
                    }
                    ## Check for the Book files
                    if ((Get-ChildItem *.pdf, *.epub) -or (Get-ChildItem .\Documents (Get-ChildItem *.pdf, *.epub))) {
                        ## Test if there is already a Book folder, move the files into it
                        if (Get-ChildItem  -Filter .\Documents\Book) { 
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.pdf' -or $_.Name -like '*.epub' } | Move-Item -Destination $path\Documents\Book
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Book
                            $found = Get-ChildItem .\Documents | Where-Object { $_.Name -like '*.pdf' -or $_.Name -like '*.epub' } | Move-Item -Destination $path\Documents\Book
                        }
                        try {
                            if ($null -eq $found) {
                                Safwan  ## produce an error to do the catch block
                            }
                        }
                        catch {
                            Get-ChildItem | Where-Object { $_.Name -like '*.pdf' -or $_.Name -like '*.epub' } | Move-Item -Destination $path\Documents\Book 
                        }
                        
                    }

                    ## Check for the text files
                    if ((Get-ChildItem  *.txt, *.srt, *.asm) -or (Get-ChildItem .\Documents (Get-ChildItem *.txt, *.srt, *.asm))) {
                        ## Test if there is already a Text folder, move the files into it
                        if (Get-ChildItem -Filter .\Documents\Text) { 
                            $found = Get-ChildItem .\Documents -Exclude 'Old Order.txt' | Where-Object { $_.Name -like '*.txt' -or $_.Name -like '*.srt' -or $_.Name -like '*.asm' } | Move-Item -Destination $path\Documents\Text
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Text
                            $found = Get-ChildItem .\Documents -Exclude 'Old Order.txt' | Where-Object { $_.Name -like '*.txt' -or $_.Name -like '*.srt' -or $_.Name -like '*.asm' } | Move-Item -Destination $path\Documents\Text
                        }
                        try {
                            if ($null -eq $found) {
                                Safwan  ## produce an error to do the catch block
                            }
                        }
                        catch {
                            Get-ChildItem -Exclude 'Old Order.txt' | Where-Object { $_.Name -like '*.txt' -or $_.Name -like '*.srt' -or $_.Name -like '*.asm' } | Move-Item -Destination $path\Documents\Text
                        }
                    }
                }
                                
                else {
                    new-item -ItemType Directory -Path $path\Documents
                    ##check for the word files
                    if (Get-ChildItem  *.doc*) {
                        ##test if there already is a Word folder and move the files
                        if (Get-ChildItem -Filter .\Documents\Word) { 
                            Get-ChildItem  | Where-Object { $_.Name -like '*.doc*' } | Move-Item -Destination $path\Documents\Word 
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Word
                            Get-ChildItem  | Where-Object { $_.Name -like '*.doc*' } | Move-Item -Destination $path\Documents\Word
                                    
                        }
                        
                    }
                    ## Check for the Excel files

                    if (Get-ChildItem *.xls*) {
                        ## Test if there is already an excel folder and move the files
                        if (Get-ChildItem -Filter .\Documents\Excel) { 
                            Get-ChildItem | Where-Object { $_.Name -like '*.xls*' } | Move-Item -Destination $path\Documents\Excel 
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Excel
                            Get-ChildItem | Where-Object { $_.Name -like '*.xls*' } | Move-Item -Destination $path\Documents\Excel
                        } 
                        
                    }
                    ## Check for the Presentation files
                    if (Get-ChildItem *.ppt*, *.pps*) {
                        ## Test if there is already a presentation folder, move the files into it
                        if (Get-ChildItem -Filter .\Documents\Presentation) { 
                            Get-ChildItem | Where-Object { $_.Name -like '*.ppt*' -or $_.name -like '*.pps*' } | Move-Item -Destination $path\Documents\Presentation 
                        }
                        ## if not create one and move the files to it
                        else {

                            New-Item -ItemType Directory -Path .\Documents\Presentation
                            Get-ChildItem | Where-Object { $_.Name -like '*.ppt*' -or $_.name -like '*.pps*' } | Move-Item -Destination $path\Documents\Presentation
                        } 
                        
                    }
                    ## Check for the Book files
                    if (Get-ChildItem *.pdf, *.epub) {
                        ## Test if there is already a book folder and move the files
                        if (Get-ChildItem -Filter .\Documents\Book) { 
                            Get-ChildItem | Where-Object { $_.Name -like '*.pdf' -or $_.Name -like '*.epub' } | Move-Item -Destination $path\Documents\Book 
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path .\Documents\Book
                            Get-ChildItem | Where-Object { $_.Name -like '*.pdf' -or $_.Name -like '*.epub' } | Move-Item -Destination $path\Documents\Book
                        } 
                        
                    }

                    ## Check for the text files
                    if (Get-ChildItem *.txt, *.srt, *.asm) {
                        ## Test if there is already an Text folder and move the files
                        if (Get-ChildItem -Filter .\Documents\Text) { 
                            Get-ChildItem -Exclude 'Old Order.txt' | Where-Object { $_.Name -like '*.txt' -or $_.Name -like '*.srt' -or $_.Name -like '*.asm' } | Move-Item -Destination $path\Documents\Text 
                        }
                        ## if not create one and move the files to it
                        else {
                            New-Item -ItemType Directory -Path $path\Documents\Text
                            Get-ChildItem -Exclude 'Old Order.txt' | Where-Object { $_.Name -like '*.txt' -or $_.Name -like '*.srt' -or $_.Name -like '*.asm' } | Move-Item -Destination $path\Documents\Text
                        } 
                        
                    }
                }
            
            }
                
            "no" {
                if (Get-ChildItem -Filter Documents) {
                    Get-ChildItem -File -Exclude 'Old Order.txt' | Where-Object { $_.Name -like "*.doc*" -or $_.Name -like "*.xls*" -or $_.Name -like "*.ppt*" -or $_.Name -like "*pps*" `
                            -or $_.Name -like "*pdf" -or $_.Name -like "*txt" } | Move-Item  -Destination $path\Documents
                }
                else {
                    new-item -ItemType Directory -Path $path\Documents
                    Get-ChildItem -Exclude 'Old Order.txt' | Where-Object { $_.Name -like "*.doc*" -or $_.Name -like "*.xls*" -or $_.Name -like "*.ppt*" -or $_.Name -like "*pps*" `
                            -or $_.Name -like "*pdf" -or $_.Name -like "*txt" } | Move-Item  -Destination $path\Documents
                }
                    
            }
        }
    }
    ## Check for the Compressed files
    if (Get-ChildItem  *.zip, *.rar) {
        ## Test if there is already a Compressed folder and move the files
        if (Get-ChildItem -Filter Compressed) { Get-ChildItem | Where-Object { $_.Name -like "*.zip" -or $_.Name -like "*.rar" } | Move-Item  -Destination $path\Compressed }
        ## if not create one and move the files to it
        else {
            new-item -ItemType Directory -Path $path\Compressed
            Get-ChildItem | Where-Object { $_.Name -like "*.zip" -or $_.Name -like "*.rar" } | Move-Item  -Destination $path\Compressed
        }
           
    }
    if (Get-ChildItem *.jpeg, *.jpg, *.png, *.gif, *.tiff, *.bmp) {
        if (Get-ChildItem -Filter Images) {
            Get-ChildItem | Where-Object { $_.Name -like "*.jpeg" -or $_.Name -like "*.jpg" -or $_.Name -like "*.png" -or $_.Name -like "*.gif" -or $_.Name -like "*.tiff" -or `
                    $_.Name -like "*.bmp" } | Move-Item -Destination $path\Images
        }
        else {
            New-Item -ItemType Directory -Path $path\Images
            Get-ChildItem | Where-Object { $_.Name -like "*.jpeg" -or $_.Name -like "*.jpg" -or $_.Name -like "*.png" -or $_.Name -like "*.gif" -or $_.Name -like "*.tiff" -or `
                    $_.Name -like "**.bmp" } | Move-Item -Destination $path\Images
        }
            
            
    }
    if (Get-ChildItem  *.exe, *.msi) {
        if (Get-ChildItem -Filter Apps) { Get-ChildItem | Where-Object { $_.Name -like "*.exe" -or $_.Name -like "*.msi" } | Move-Item -Destination $path\Apps }
        else {
            New-Item -ItemType Directory -Path $path\Apps
            Get-ChildItem | Where-Object { $_.Name -like "*.exe" -or $_.Name -like "*.msi" } | Move-Item -Destination $path\Apps
        }
            
           
    }
    if (Get-ChildItem  *.WEBM, *.ogg, *.MP4, *.m4v, *.avi, *.wmv, *.mov, *.flv, *.swf, *.avchd) {
        if (Get-ChildItem -Filter Movies) {
            Get-ChildItem | Where-Object { $_.Name -like "*.WEBM" -or $_.Name -like "*.ogg" -or $_.Name -like "*.MP4" -or $_.Name -like "*.m4v" `
                    -or $_.Name -like "*.avi" -or $_.Name -like "*.wmv" -or $_.Name -like "*.mov" -or $_.Name -like "*.flv" -or $_.Name -like "*.swf" -or $_.Name -like "*.avchd" } `
            | Move-Item -Destination $path\Movies
        }
        else {
            New-Item -ItemType Directory -Path $path\Movies
            Get-ChildItem | Where-Object { $_.Name -like "*.WEBM" -or $_.Name -like "*.ogg" -or $_.Name -like "*.MP4" -or $_.Name -like "*.m4v" `
                    -or $_.Name -like "*.avi" -or $_.Name -like "*.wmv" -or $_.Name -like "*.mov" -or $_.Name -like "*.flv" -or $_.Name -like "*.swf" -or $_.Name -like "*.avchd" } `
            | Move-Item -Destination $path\Movies
        }
            
    }
    if (Get-ChildItem  *.mp3, *.wav, *.wma, *.dcd, *.alac, *.acc, *.flac, *.aiff) {
                
        if (Get-ChildItem -Filter Audios) {
            Get-ChildItem  | Where-Object { $_.name -like "*.mp3" -or $_.name -like "*.wav" -or $_.name -like "*.wma" -or $_.name -like "*.dcd" -or $_.name -like `
                    "*.alac" -or $_.name -like "*.acc" -or $_.name -like "*.flac" -or $_.name -like "*.aiff" } | Move-Item -Destination $path\Audios
        }
        else {
            New-Item -ItemType Directory -Path $path\Audios
            Get-ChildItem  | Where-Object { $_.name -like "*.mp3" -or $_.name -like "*.wav" -or $_.name -like "*.wma" -or $_.name -like "*.dcd" -or $_.name -like `
                    "*.alac" -or $_.name -like "*.acc" -or $_.name -like "*.flac" -or $_.name -like "*.aiff" } | Move-Item -Destination $path\Audios
        }
            
    }
}
if ( Get-ChildItem -Exclude *.txt, *.doc*, *.xls*, *.ppt*, *.pps*, *pdf, *.zip, *.rar, *.jpeg, *.jpg, *.png, *.gif, *.tiff, *.exe, *.msi, *.WEBM, *.ogg, *.MP4, *.m4v, *.avi, *.wmv, *.mov, *.flv, *.swf, *.avchd, *.mp3, *.wav, *.wma, *.dcd, *.alac, *.acc, *.flac, *.aiff, *.bmp | Where-Object { $_.Extension -and $_.Mode -like "*[arsh]*" }) {
    if (Get-ChildItem -Filter Other) {
        Get-ChildItem -Exclude *.txt, *.doc*, *.xls*, *.ppt*, *.pps*, *pdf, *.zip, *.rar, *.jpeg, *.jpg, *.png, *.gif, *.tiff, *.exe, *.msi, *.WEBM, *.ogg, *.MP4, *.m4v, *.avi, *.wmv, *.mov, *.flv, *.swf, *.avchd, *.mp3, *.wav, *.wma, *.dcd, *.alac, *.acc, *.flac, *.aiff, *.bmp | Where-Object { $_.Extension -and $_.Mode -like "*[arsh]*" } | Move-Item -Destination $path\Other
    }
    else {
        New-Item -ItemType Directory -Path $path\Other
        Get-ChildItem -Exclude *.txt, *.doc*, *.xls*, *.ppt*, *.pps*, *pdf, *.zip, *.rar, *.jpeg, *.jpg, *.png, *.gif, *.tiff, *.exe, *.msi, *.WEBM, *.ogg, *.MP4, *.m4v, *.avi, *.wmv, *.mov, *.flv, *.swf, *.avchd, *.mp3, *.wav, *.wma, *.dcd, *.alac, *.acc, *.flac, *.aiff, *.bmp | Where-Object { $_.Extension -and $_.Mode -like "*[arsh]*" } | Move-Item -Destination $path\Other
    } 
}
          
Write-host "`n`n`n`t`t`tYour folder has been organized, and now it looks something like this:`n"
tree 
function CtrlZ {
    process {
        Get-ChildItem -Recurse -File  | Where-Object { $_.Name -in (Get-Content 'Old Order.txt') } | Move-Item  -Destination $path
        foreach ($folder in (Get-ChildItem -Directory)) {
            if (-not(Get-ChildItem -file -Recurse $folder)) {
                Remove-Item -Path $folder
            }
        }  
    }
}
$2DoOrNot2do = Read-Host "`n`n`n`t`t`tLiterally type 'CtrlZ' if you want to undo your changes or hit 'Enter' to exit"
switch ($2DoOrNot2do) {
    "CtrlZ" {
        CtrlZ
        read-host "Hit the 'Enter' key to exit"
    }
    Default {
        break
    }
}

