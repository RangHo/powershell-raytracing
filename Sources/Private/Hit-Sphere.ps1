function Hit-Sphere
{
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory)]
        [Vector3]$Center,

        [Parameter(Mandatory)]
        [double]$Radius,

        [Parameter(Mandatory)]
        [Ray]$Ray
    )

    process
    {
        $oc = $Ray.Origin - $Center
        $a = $Ray.Direction.Dot($Ray.Direction)
        $b = 2 * $oc.Dot($Ray.Direction)
        $c = $oc.Dot($oc) - $Radius * $Radius
        $discriminant = $b * $b - 4 * $a * $c

        Write-Output ($discriminant -gt 0)
    }
}
