function Hit-Sphere
{
    [CmdletBinding()]
    [OutputType([double])]
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
        $a = $Ray.Direction.LengthSquared()
        $h = $oc.Dot($Ray.Direction)
        $c = $oc.LengthSquared() - $Radius * $Radius
        $discriminant = $h * $h - $a * $c

        if ($discriminant -lt 0)
        {
            return $null
        }

        Write-Output ((-$h - [Math]::Sqrt($discriminant)) / $a)
    }
}
