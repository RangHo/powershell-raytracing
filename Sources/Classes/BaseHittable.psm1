using module .\Ray.psm1
using module .\HitResult.psm1

class BaseHittable
{
    BaseHittable()
    {
        # This is a base class, so it should never be instantiated.
        if ($this.GetType() -eq [BaseHittable])
        {
            throw "BaseHittable is an abstract class and cannot be instantiated."
        }
    }

    [HitResult]Hit([Ray]$ray, [double]$tMin, [double]$tMax)
    {
        throw "[BaseHittable]::Hit() is an abstract method and must be overridden."
    }
}
