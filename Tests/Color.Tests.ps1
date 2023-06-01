using module ..\Sources\Classes\Color.psm1

BeforeAll {
    Add-Type -AssemblyName System.Drawing
}

Describe "Class Color" {
    It "Is a class extending Vector3" {
        [Color].BaseType | Should -Be Vector3
    }

    It "Should have aliases properties of X, Y, Z" {
        $color = [Color]::new(1, 2, 3)
        $color.X | Should -Be $color.R
        $color.Y | Should -Be $color.G
        $color.Z | Should -Be $color.B
    }

    It "Should be able to explicitly convert to System.Drawing.Color" {
        $color = [Color]::new(0.5, 0.5, 0.5)
        $drawingColor = $color -as [System.Drawing.Color]
        $drawingColor.GetType().FullName | Should -Be "System.Drawing.Color"
        $drawingColor.R | Should -Be 128
        $drawingColor.G | Should -Be 128
        $drawingColor.B | Should -Be 128
    }

    It "Should be able to implicitly convert to System.Drawing.Color" {
        $color = [Color]::new(0.5, 0.5, 0.5)
        $drawingColor = [System.Drawing.Color]$color
    }
}
