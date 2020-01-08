
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$WordCount = 3,
        [int]$MaxCharacterLength = 6,
        [Switch]$useWords
    )#end Param()

    #$words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    if($PSBoundParameters.ContainsKey('useWords')){
        #write-warning "using words from parameters"
        #$words = Import-Csv -Delimiter "`t" (Join-Path "E:\My_Docs\repos\Modules\SCCCDModules\New-RandomWords\" "nautical_terms_stripped.csv")
        $words = Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "nautical_terms_stripped.csv")
        #$words | Get-Member

    }else{
        $words = Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "eff_large_wordlist.csv")
    }
    Write-Verbose "Word count: $($words.count)"
    $randoWords = Get-Random -InputObject $($words.word.ToLower().Where({$PSItem.Length -le $MaxCharacterLength})) -Count $WordCount
    $strPassword = "{0} {1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($randoWords[0])),$($randoWords[1..$($randoWords.Count)] -join ' '),$(@('.','?','!') | Get-Random)    
    $password = ConvertTo-SecureString -Force -AsPlainText $strPassword
    #$password
    #$strPassword

    [PSCustomObject]@{
        AccountPassword = $password
        PlainPassword = $strPassword
    }#end PSCustomObject
}#end function New-RandomWords