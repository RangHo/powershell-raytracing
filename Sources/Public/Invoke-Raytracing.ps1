using module ..\Classes\Color.psm1

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

                [Color]$pixel = [Color]::new(
                    ($x -as [double]) / ($ImageWidth - 1),
                    ($y -as [double]) / ($ImageHeight - 1),
                    0.25
                )

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
