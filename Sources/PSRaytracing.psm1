# Load needed assemblies
Add-Type -AssemblyName System.Drawing

# Get list of function defintion files
$public = @(Get-ChildItem -Path $PSScriptRoot\Public -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)
$private = @(Get-ChildItem -Path $PSScriptRoot\Private -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue)

# Source all files
foreach ($file in ($private + $public))
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
