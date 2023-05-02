using module .\Vector3.psm1

class Color : Vector3
{
    Color([double]$r, [double]$g, [double]$b) : base($r, $g, $b)
    {
        $this | Add-Member `
          -MemberType ScriptProperty `
          -Name R `
          -Value { $this.X } `
          -SecondValue { param([double]$Value) $this.X = $Value }
        $this | Add-Member `
          -MemberType ScriptProperty `
          -Name G `
          -Value { $this.Y } `
          -SecondValue { param([double]$Value) $this.Y = $Value }
        $this | Add-Member `
          -MemberType ScriptProperty `
          -Name B `
          -Value { $this.Z } `
          -SecondValue { param([double]$Value) $this.Z = $Value }
    }

    [System.Drawing.Color] ToDrawingColor()
    {
        [int]$ir = $this.R * 255 -as [int]
        [int]$ig = $this.G * 255 -as [int]
        [int]$ib = $this.B * 255 -as [int]
        return [System.Drawing.Color]::FromArgb($ir, $ig, $ib)
    }

    static [System.Drawing.Color]op_Implicit([Color]$color)
    {
        return $color.ToDrawingColor()
    }

    static [System.Drawing.Color]op_Explicit([Color]$color)
    {
        return $color.ToDrawingColor()
    }
}
