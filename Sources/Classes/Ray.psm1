using module .\Vector3.psm1

class Ray
{
    [Vector3]$Origin
    [Vector3]$Direction

    Ray([Vector3]$origin, [Vector3]$direction)
    {
        $this.Origin = $origin
        $this.Direction = $direction
    }

    [Vector3]At([double]$t)
    {
        return $this.Origin + $this.Direction * $t
    }
}

function New-Ray
{
    [CmdletBinding()]
    [OutputType([Ray])]
    param(
        [Parameter(Mandatory, Position = 0)]
        [Vector3]$Origin,

        [Parameter(Mandatory, Position = 1)]
        [Vector3]$Direction
    )

    Write-Output ([Ray]::new($Origin, $Direction))
}

Export-ModuleMember -Function New-Ray
