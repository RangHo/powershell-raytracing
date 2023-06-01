using module .\Ray.psm1
using module .\BaseHittable.psm1
using module .\HitResult.psm1

class HittableList : BaseHittable, System.Collections.IEnumerable
{
    [System.Collections.ArrayList]$Objects

    HittableList()
    {
        $this.Objects = [System.Collections.ArrayList]::new()
    }

    [HitResult]Hit([Ray]$ray, [double]$tMin, [double]$tMax)
    {
        $lastHitResult = [HitResult]::NoHit
        $lastClosest = $tMax

        foreach ($object in $this.Objects)
        {
            $currentHitResult = $object.Hit($ray, $tMin, $lastClosest)
            if ($currentHitResult.IsAvailable)
            {
                $lastHitResult = $currentHitResult
                $lastClosest = $currentHitResult.T
            }
        }

        return $lastHitResult
    }

    [System.Collections.IEnumerator]GetEnumerator()
    {
        return $this.Objects.GetEnumerator()
    }
}

function New-HittableList
{
    [CmdletBinding()]
    [OutputType([HittableList])]
    param(
        [Parameter(Position=0)]
        [object[]]$Objects
    )

    begin
    {
        if ($Objects -eq $null)
        {
            $Objects = @()
        }
        $hittableList = [HittableList]::new()
    }
    process
    {
        foreach ($object in $Objects)
        {
            # Sanity check
            if ($object.GetType().BaseType.Name -ne 'BaseHittable')
            {
                throw "Object is not hittable."
            }
            $hittableList.Objects.Add($object) | Out-Null
        }
    }
    end
    {
        Write-Output -NoEnumerate $hittableList
    }
}

Export-ModuleMember -Function New-HittableList
