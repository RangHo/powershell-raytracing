function Get-RayColor
{
    [CmdletBinding()]
    [OutputType([Color])]
    param(
        # The ray to get the color for.
        [Parameter(ValueFromPipeline)]
        [Ray]$Ray
    )

    process
    {
        # Sanity check
        if ($Ray.GetType().Name -ne 'Ray')
        {
            throw "Expected a Ray object, got $($Ray.GetType().Name)"
        }

        $t = Hit-Sphere -Center (New-Vector3 0 0 1) -Radius 0.5 -Ray $Ray

        if ($t)
        {
            $normal = ($Ray.At($t) - (New-Vector3 0 0 -1)).Normal()
            return (New-Color ($normal.X + 1) ($normal.Y + 1) ($normal.Z + 1)) / 2
        }

        $normalDirection = $Ray.Direction.Normal()
        $t = 0.5 * ($normalDirection.Y + 1.0)
        $color = `
          [Color]::new(1, 1, 1) * (1.0 - $t) `
          + [Color]::new(0.5, 0.7, 1.0) * $t

        Write-Output $color
    }
}
