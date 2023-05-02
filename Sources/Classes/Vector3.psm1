class Vector3
{
    [double]$X

    [double]$Y

    [double]$Z

    static [Vector3]$Zero = [Vector3]::new(0, 0, 0)

    Vector3([Vector3]$that)
    {
        $this.X = $that.X
        $this.Y = $that.Y
        $this.Z = $that.Z
    }

    Vector3([double]$x, [double]$y, [double]$z)
    {
        $this.X = $x
        $this.Y = $y
        $this.Z = $z
    }

    [double]LengthSquared()
    {
        return $this.Dot($this)
    }

    [double]Length()
    {
        return [System.Math]::Sqrt($this.LengthSquared())
    }

    [double]Dot([Vector3]$that)
    {
        return `
            $this.X * $that.X `
            + $this.Y * $that.Y `
            + $this.Z * $that.Z
    }

    [Vector3]Cross([Vector3]$that)
    {
        return [Vector3]::new(
            $this.Y * $that.Z - $this.Z * $that.Y,
            $this.Z * $that.X - $this.X * $that.Z,
            $this.X * $that.Y - $this.Y * $that.X
        )
    }

    static [Vector3]op_Addition([Vector3]$a, [Vector3]$b)
    {
        return [Vector3]::new($a.X + $b.X, $a.Y + $b.Y, $a.Z + $b.Z)
    }

    static [Vector3]op_Subtraction([Vector3]$a, [Vector3]$b)
    {
        return [Vector3]::new($a.X - $b.X, $a.Y - $b.Y, $a.Z - $b.Z)
    }

    static [Vector3]op_Multiply([double]$scalar, [Vector3]$vector)
    {
        return [Vector3]::new(
            $scalar * $vector.X,
            $scalar * $vector.Y,
            $scalar * $vector.Z
        )
    }

    static [Vector3]op_Multiply([Vector3]$vector, [double]$scalar)
    {
        return [Vector3]::new(
            $scalar * $vector.X,
            $scalar * $vector.Y,
            $scalar * $vector.Z
        )
    }

    static [Vector3]op_Division([Vector3]$vector, [double]$scalar)
    {
        return [Vector3]::new(
            $vector.X / $scalar,
            $vector.Y / $scalar,
            $vector.Z / $scalar
        )
    }
}
