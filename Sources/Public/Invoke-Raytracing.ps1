<#
.SYNOPSIS
Renders a scene using raytracing techniques.

.DESCRIPTION
Renders a scene using raytracing techniques.
If no arguments specifying the image size are provided, it will default to a
square image of 256x256 pixels.

Note that this cmdlet uses vector arithmetic implemented in PowerShell only. Due
to this nature, image generation is extremely slow. Currently there is no plan
to improve the performance of this cmdlet, as it aims to be a pure-PowerShell
implementation of raytracing techniques.

.INPUTS
None. For now, the scene is hard-coded in the script.

.OUTPUTS
None. This cmdlet creates a PPM file in the current directory.

.LINK
https://github.com/RangHo/powershell-raytracing
#>
function Invoke-Raytracing
{
    [CmdletBinding()]
    param(
        # Width of the rendered output.
        [Parameter()]
        [int]$ImageWidth = 0,

        # Height of the rendered output.
        [Parameter()]
        [int]$ImageHeight = 0,

        # Camera object that renders the output.
        [Parameter()]
        [Camera]$Camera = $null,

        # Number of samples to use for anti-aliasing. Default is 4.
        [Parameter()]
        [int]$Samples = 4,

        # Name of the output file.
        [Parameter()]
        [string]$OutputFile = "output.ppm"
    )

    begin
    {
        # Camera settings
        if ($Camera -eq $null -or $Camera.GetType().Name -ne "Camera")
        {
            # Make sure both image width and height are specified
            if ($ImageWidth -eq 0 -or $ImageHeight -eq 0)
            {
                throw "Both image width and height must be specified in order to use implicit camera."
            }

            # Create camera
            $aspectRatio = $ImageWidth / $ImageHeight
            $Camera = New-Camera -AspectRatio $aspectRatio -FocalLength 1.0
        }

        # Image dimension settings
        if ($ImageWidth -eq 0 -and $ImageHeight -eq 0)
        {
            throw "At least image width or height must be specified to infer the resulting image dimension."
        }
        if ($ImageWidth -eq 0)
        {
            $ImageWidth = $ImageHeight * $Camera.AspectRatio -as [int]
        }
        if ($ImageHeight -eq 0)
        {
            $ImageHeight = $ImageWidth / $Camera.AspectRatio -as [int]
        }

        # File name settings
        if (-not $OutputFile.EndsWith(".ppm"))
        {
            $OutputFile = $OutputFile + ".ppm"
        }

        # Scene objects
        $scene = New-HittableList @(
            New-Sphere -Center (New-Vector3 0 0 -1) -Radius 0.5
            New-Sphere -Center (New-Vector3 0 -100.5 -1) -Radius 100
        )
    }

    process
    {
        # Create a new text file to store the PPM output
        New-Item -Path $OutputFile -ItemType File -Force

        # Write the PPM header
        Add-Content -Path $OutputFile -Value "P3"
        Add-Content -Path $OutputFile -Value "$ImageWidth $ImageHeight"
        Add-Content -Path $OutputFile -Value "255"

        # Render the image
        foreach ($y in ($ImageHeight - 1)..0)
        {
            foreach ($x in 0..($ImageWidth - 1))
            {
                # Write the current process
                Write-Progress `
                  -Activity "Rendering image" `
                  -Status "Rendering pixel ($x, $y)" `
                  -PercentComplete ((($ImageHeight - 1 - $y) * $ImageWidth + $x) / ($ImageWidth * $ImageHeight) * 100)

                $pixel = New-Color 0 0 0
                foreach ($aa in 0..($Samples - 1))
                {
                    # Cast a ray to determine the current pixel
                    $u = ($x + (Get-Random -Minimum 0.0 -Maximum 1.0)) / ($ImageWidth - 1)
                    $v = ($y + (Get-Random -Minimum 0.0 -Maximum 1.0)) / ($ImageHeight - 1)
                    $pixel += $Camera.To($u, $v) | Get-RayColor -World $scene
                }

                # Average the color
                $pixel /= $Samples

                # Convert the color to 0-255 range integer 3-tuple
                $ir = [Math]::Min(255, [Math]::Floor(256 * $pixel.R))
                $ig = [Math]::Min(255, [Math]::Floor(256 * $pixel.G))
                $ib = [Math]::Min(255, [Math]::Floor(256 * $pixel.B))

                # Write the pixel to the PPM file
                Add-Content -Path $OutputFile -Value "$ir $ig $ib"
            }
        }
    }
}
