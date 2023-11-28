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

    static [Color]op_Addition([Color]$a, [Color]$b)
    {
        return [Color]::new(
            $a.R + $b.R,
            $a.G + $b.G,
            $a.B + $b.B
        )
    }

    static [Color]op_Subtraction([Color]$a, [Color]$b)
    {
        return [Color]::new(
            $a.R - $b.R,
            $a.G - $b.G,
            $a.B - $b.B
        )
    }

    static [Color]op_Multiply([double]$scalar, [Color]$color)
    {
        return [Color]::new(
            $scalar * $color.R,
            $scalar * $color.G,
            $scalar * $color.B
        )
    }

    static [Color]op_Multiply([Color]$color, [double]$scalar)
    {
        return [Color]::new(
            $scalar * $color.R,
            $scalar * $color.G,
            $scalar * $color.B
        )
    }

    static [Color]op_Division([Color]$color, [double]$scalar)
    {
        return [Color]::new(
            $color.R / $scalar,
            $color.G / $scalar,
            $color.B / $scalar
        )
    }
}

function New-Color
{
    [CmdletBinding(DefaultParameterSetName='0to1')]
    [OutputType([Color])]
    param(
        [Parameter(Mandatory, ParameterSetName='0to1', Position=0)]
        $R,

        [Parameter(Mandatory, ParameterSetName='0to1', Position=1)]
        $G,

        [Parameter(Mandatory, ParameterSetName='0to1', Position=2)]
        $B,

        [Parameter(Mandatory, ParameterSetName='0to255', Position=0)]
        $IR,

        [Parameter(Mandatory, ParameterSetName='0to255', Position=1)]
        $IG,

        [Parameter(Mandatory, ParameterSetName='0to255', Position=2)]
        $IB,

        [Parameter(Mandatory, ParameterSetName='Vector')]
        [Vector3]$Vector
    )

    if ($PSCmdlet.ParameterSetName -eq '0to1')
    {
        Write-Output ([Color]::new($R, $G, $B))
    }
    elseif ($PSCmdlet.ParameterSetName -eq '0to255')
    {
        Write-Output ([Color]::new($IR -as [double] / 255, $IG -as [double] / 255, $IB -as [double] / 255))
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'Vector')
    {
        Write-Output ([Color]::new($Vector.X, $Vector.Y, $Vector.Z))
    }
}

Export-ModuleMember -Function New-Color
