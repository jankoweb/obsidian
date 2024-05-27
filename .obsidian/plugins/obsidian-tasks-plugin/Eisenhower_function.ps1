# Tasks Plugin Obsidian to Eisenhover priority
# Author: Janko, 27.5.24
#
# path
$filePath = "main.js"

# read file
$content = Get-Content -Raw -Path $filePath

# escape $: `$ [https://ss64.com/ps/syntax-esc.html]

# replacements
$replacements = @(
    # strings for sections
    @{
        OldValue = @"
{e} priority
"@
        NewValue = @"
{e.replace("Highest","A důležité, spěchá").replace("High","B nedůležité, spěchá").replace("Medium","C důležité, nespěchá").replace("Lowest","E wishlist").replace("Low","D nedůležité, nespěchá").replace("Normal","Přiřadit")}
"@
    },
    # strings for context menu and remove icon (because of accesskey); 
    @{
        OldValue = @"
{T.toLowerCase()} priority
"@
        NewValue = @"
{T.toLowerCase().replace("highest","AA důležité, spěchá").replace("high","BB nedůležité, spěchá").replace("medium","CC důležité, nespěchá").replace("lowest","DD wishlist").replace("low","EE nedůležité, nespěchá")}
"@
    }
)

# replace strings
foreach ($replacement in $replacements) {
    $content = $content -replace [regex]::Escape($replacement.OldValue), $replacement.NewValue
}

# save file
Set-Content -Path $filePath -Value $content

Write-Host "Done."
