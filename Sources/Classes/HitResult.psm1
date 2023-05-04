using module .\Vector3.psm1

class HitResult
{
    [bool]$IsAvailable
    
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
}
