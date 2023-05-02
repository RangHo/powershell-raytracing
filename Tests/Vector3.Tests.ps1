using module ..\Sources\Classes\Vector3.psm1

Describe "Class Vector3" {
    It "Should be able to create a Vector3" {
        $v = [Vector3]::new(1, 2, 3)
        $v.GetType().Name | Should -Be "Vector3"
    }

    It "Creates a copy of an existing vector" {
        $v = [Vector3]::new(1, 2, 3)
        $v2 = [Vector3]::new($v)
        $v2.GetType().Name | Should -Be "Vector3"
        $v2.X | Should -Be 1
        $v2.Y | Should -Be 2
        $v2.Z | Should -Be 3
    }

    It "Has a static zero vector" {
        [Vector3]::Zero.GetType().Name | Should -Be "Vector3"
        [Vector3]::Zero.X | Should -Be 0
        [Vector3]::Zero.Y | Should -Be 0
        [Vector3]::Zero.Z | Should -Be 0
    }

    It "Should be able to normalize itself" {
        $v = [Vector3]::new(1, 2, 3)
        $v.Length() | Should -Not -Be 1
        $vNormal = $v.Normalize()
        $vNormal.Length() | Should -Be 1
    }

    It "Should be able to add two vectors" {
        $v1 = [Vector3]::new(1, 2, 3)
        $v2 = [Vector3]::new(4, 5, 6)
        $v3 = $v1 + $v2
        $v3.GetType().Name | Should -Be "Vector3"
        $v3.X | Should -Be 5
        $v3.Y | Should -Be 7
        $v3.Z | Should -Be 9
    }

    It "Should be able to subtract two vectors" {
        $v1 = [Vector3]::new(4, 5, 6)
        $v2 = [Vector3]::new(1, 2, 3)
        $v3 = $v1 - $v2
        $v3.GetType().Name | Should -Be "Vector3"
        $v3.X | Should -Be 3
        $v3.Y | Should -Be 3
        $v3.Z | Should -Be 3
    }

    It "Should be able to multiply with a scalar" {
        $v = [Vector3]::new(1, 2, 3)
        $v2 = $v * 2
        $v2.GetType().Name | Should -Be "Vector3"
        $v2.X | Should -Be 2
        $v2.Y | Should -Be 4
        $v2.Z | Should -Be 6
        $2v = 2 * $v
        $2v.GetType().Name | Should -Be "Vector3"
        $2v.X | Should -Be 2
        $2v.Y | Should -Be 4
        $2v.Z | Should -Be 6
    }

    It "Should be able to divide with a scalar" {
        $v = [Vector3]::new(2, 4, 6)
        $v2 = $v / 2
        $v2.GetType().Name | Should -Be "Vector3"
        $v2.X | Should -Be 1
        $v2.Y | Should -Be 2
        $v2.Z | Should -Be 3
    }

    It "Should calculate a dot product of two vectors" {
        $v1 = [Vector3]::new(1, 2, 3)
        $v2 = [Vector3]::new(4, 5, 6)
        $dot = $v1.Dot($v2)
        $dot | Should -Be 32
    }

    It "Should calculate a cross product of two vectors" {
        $v1 = [Vector3]::new(1, 2, 3)
        $v2 = [Vector3]::new(4, 5, 6)
        $v3 = $v1.Cross($v2)
        $v3.GetType().Name | Should -Be "Vector3"
        $v3.X | Should -Be -3
        $v3.Y | Should -Be 6
        $v3.Z | Should -Be -3
    }
}
