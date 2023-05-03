<#
.SYNOPSIS
    Renders a scene using raytracing techniques.
#>
function Invoke-Raytracing
{
    [CmdletBinding()]
    param(
        # Width of the rendered output.
        [Parameter()]
        [int]$ImageWidth = 256,

        # Height of the rendered output.
        [Parameter()]
        [int]$ImageHeight = 256,

        # Name of the output file.
        [Parameter()]
        [string]$OutputFile = "output.png"
    )

    begin
    {
        # Image settings
        $aspectRatio = $ImageWidth / $ImageHeight

        # Camera settings
        $viewportHeight = 2.0
        $viewportWidth = $aspectRatio * $viewportHeight
        $focalLength = 1.0

        # World coordinate helpers
        $origin = [Vector3]::Zero
        $horizontal = [Vector3]::new($viewportWidth, 0, 0)
        $vertical = [Vector3]::new(0, $viewportHeight, 0)
        $lowerLeftCorner = `
          $origin `
          - ($horizontal / 2) `
          - ($vertical / 2) `
          - [Vector3]::new(0, 0, $focalLength)
    }

    process
    {
        # Create a bitmap to hold the image
        $bitmap = New-Object System.Drawing.Bitmap($ImageWidth, $ImageHeight)

        # Save the bitmap to the output file
        foreach ($y in 0..($ImageHeight - 1))
        {
            foreach ($x in 0..($ImageWidth - 1))
            {
                # Write the current process
                Write-Progress `
                  -Activity "Rendering image" `
                  -Status "Rendering pixel ($x, $y)" `
                  -PercentComplete (($y * $ImageWidth + $x) / ($ImageWidth * $ImageHeight) * 100)

                # Cast a ray to determine the current pixel
                $u = ($x -as [double]) / ($ImageWidth - 1)
                $v = ($y -as [double]) / ($ImageHeight - 1)
                $destination = `
                  $lowerLeftCorner `
                  + ($horizontal * $u) `
                  + ($vertical * $v) `
                  - $origin
                $pixel = [Ray]::new($origin, $destination) | Get-RayColor

                # Set the pixels at the current location
                # Note that the y-coordinate is flipped as the bitmap is stored
                # top-to-bottom, unlike the world coordinate
                $bitmap.SetPixel(
                    $x,
                    $ImageHeight - $y - 1,
                    $pixel
                )
            }
        }
        $bitmap.Save($OutputFile, [System.Drawing.Imaging.ImageFormat]::Png)
    }
}
