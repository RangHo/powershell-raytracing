using module .\Vector3.psm1
using module .\Ray.psm1

class HitResult
{
    [bool]$IsAvailable

    [bool]$IsFrontFacing
    
    [Vector3]$Position

    [Vector3]$Normal

    [double]$Distance

    static [HitResult]$NoHit = [HitResult]::new($false)

    hidden HitResult([bool]$isAvailable)
    {
        $this.IsAvailable = $isAvailable
        $this.Position = $null
        $this.Normal = $null
        $this.Distance = $null
    }

    [void]Validate([Ray]$ray)
    {
        $this.IsFrontFacing = $ray.Direction.Dot($this.Normal) -lt 0
        $this.Normal = if ($this.IsFrontFacing) { $this.Normal } else { -1 * $this.Normal }
    }
}
