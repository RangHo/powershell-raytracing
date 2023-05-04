using module .\Vector3.psm1
using module .\Ray.psm1
using module .\BaseHittable.psm1
using module .\HitResult.psm1

class Sphere : BaseHittable
{
    [Vector3]$Center

    [double]$Radius

    Sphere([Vector3]$center, [double]$radius)
    {
        $this.Center = $center
        $this.Radius = $radius
    }

    [HitResult]Hit([Ray]$ray, [double]$tMin, [double]$tMax)
    {
        # Find the discriminant
        $oc = $ray.Origin - $this.Center
        $a = $ray.Direction.LengthSquared()
        $h = $oc.Dot($ray.Direction)
        $c = $oc.LengthSquared() - $this.Radius * $this.Radius
        $d = $h * $h - $a * $c

        # If discriminant is less than 0, there is no intersection
        if ($d -lt 0)
        {
            return [HitResult]::NoHit
        }

        # Find the nearest root that lies in the acceptable range
        $sqrtD = [Math]::Sqrt($d)
        $root = (-$h - $sqrtD) / $a
        if ($root -lt $tMin -or $tMax -lt $root)
        {
            $root = (-$h + $sqrtD) / $a
            if ($root -lt $tMin -or $tMax -lt $root)
            {
                return [HitResult]::NoHit
            }
        }

        $result = [HitResult]::new($true)
        $result.Position = $Ray.At($root)
        $result.Normal = ($result.Position - $this.Center) / $this.Radius
        $result.Distance = $root

        return $result
    }
}

function New-Sphere
{
    [CmdletBinding()]
    [OutputType([Sphere])]
    param(
        [Parameter(Mandatory, Position=0)]
        [Vector3]$Center,

        [Parameter(Mandatory, Position=1)]
        [double]$Radius
    )

    Write-Output ([Sphere]::new($Center, $Radius))
}

Export-ModuleMember -Function New-Sphere
