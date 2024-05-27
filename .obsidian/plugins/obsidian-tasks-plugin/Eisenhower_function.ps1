# Tasks Plugin Obsidian to Eisenhover priority
# Author: Janko, 27.5.24
#
# path
$filePath = "main.js"

# read file
$content = Get-Content -Raw -Path $filePath

# debug:
#  m=["High","Medium","Low","Highest","Lowest"] - nahrazuje context menu a pak rozsype ikony


# TODO
# potrebuji udelat replace stringu pro nahrazeni v kontext menu:
#  T.toLowerCase() -> High -> Nedůležité... atd.
# a pro sections:
#  {this.priority} -> High -> nedůležité

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
    },
    # icons - TODO tady je treba nahrazovat ty \u, protoze to je na vice mistech
    @{
        OldValue = @"
prioritySymbols:{Highest:"\u{1F53A}",High:"\u23EB",Medium:"\u{1F53C}",Low:"\u{1F53D}",Lowest:"\u23EC",None:""
"@
        NewValue = @"
prioritySymbols:{Highest:"\u{0041}",High:"\{0042}",Medium:"\u{0043}",Low:"\u{0044}",Lowest:"\u{0045}",None:""
"@
    },
    @{
        OldValue = @"
priorityRegex:/([🔺⏫🔼🔽⏬])
"@
        NewValue = @"
priorityRegex:/([ABCDE])
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
