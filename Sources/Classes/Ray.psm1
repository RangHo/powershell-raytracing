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
