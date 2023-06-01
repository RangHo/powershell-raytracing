using module .\Vector3.psm1
using module .\Ray.psm1

class Camera
{
    [double]$AspectRatio

    [Vector3]$Origin

    [Vector3]$LowerLeftCorner

    [Vector3]$Horizontal

    [Vector3]$Vertical

    Camera([double]$aspectRatio, [double]$focalLength)
    {
        $this.Origin = [Vector3]::Zero
        $this.AspectRatio = $aspectRatio

        $viewportHeight = 2.0
        $viewportWidth = $aspectRatio * $viewportHeight
        $focalLength = 1.0

        $this.Horizontal = [Vector3]::new($viewportWidth, 0.0, 0.0)
        $this.Vertical = [Vector3]::new(0.0, $viewportHeight, 0.0)
        $this.LowerLeftCorner = $this.Origin - ($this.Horizontal / 2.0) - ($this.Vertical / 2.0) - [Vector3]::new(0.0, 0.0, $focalLength)
    }

    [Ray]To([double]$u, [double]$v)
    {
        return [Ray]::new(
            $this.Origin,
            $this.LowerLeftCorner + $u * $this.Horizontal + $v * $this.Vertical - $this.Origin
        )
    }
}

function New-Camera
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [double]$AspectRatio,

        [Parameter(Mandatory)]
        [double]$FocalLength
    )

    Write-Output ([Camera]::new($AspectRatio, $FocalLength))
}

Export-ModuleMember -Function New-Camera
