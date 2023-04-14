# Get list of class and function defintion files
$classes = @(Get-ChildItem -Path $PSScriptRoot\Classes -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
$public = @(Get-ChildItem -Path $PSScriptRoot\Public -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
$private = @(Get-ChildItem -Path $PSScriptRoot\Private -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)

# Source all files
foreach ($file in ($classes + $public + $private))
{
    try
    {
        Write-Verbose "Importing $($file.FullName)"
        . $file.FullName
    }
    catch
    {
        Write-Error -Message "Failed to import $($file.FullName): $($_.Exception.Message)"
    }
}

# Export only public member functions
Export-ModuleMember -Function $public.BaseName
