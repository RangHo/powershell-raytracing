function Get-RayColor
{
    [CmdletBinding()]
    [OutputType([Color])]
    param(
        # The ray to get the color for.
        [Parameter(Mandatory, ValueFromPipeline)]
        $Ray,

        # The list of hittables available in the world.
        [Parameter()]
        $World
    )

    process
    {
        # Sanity check
        if ($Ray.GetType().Name -ne 'Ray')
        {
            throw "Expected a Ray object, got $($Ray.GetType().Name)"
        }
        if ($World.GetType().BaseType.Name -ne 'BaseHittable')
        {
            throw "Expected a BaseHittable object, got $($World.GetType().Name)"
        }

        $result = $World.Hit($Ray, 0, [double]::MaxValue)

        if ($result.IsAvailable)
        {
            Write-Output (0.5 * ((New-Color -Vector $result.Normal) + (New-Color 1 1 1)))
        }
        else
        {
            $normalDirection = $Ray.Direction.Normal()
            $t = 0.5 * ($normalDirection.Y + 1.0)
            Write-Output ([Color]::new(1, 1, 1) * (1.0 - $t) + [Color]::new(0.5, 0.7, 1.0) * $t)
        }
    }
}
