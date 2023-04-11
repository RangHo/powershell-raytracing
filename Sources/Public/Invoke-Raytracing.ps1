using assembly System.Drawing

function Invoke-Raytracing
{
    [CmdletBinding()]
    param(
        [Parameter()]
        [int]$ImageWidth = 256,

        [Parameter()]
        [int]$ImageHeight = 256,

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

                # Calculate each pixel's color in the range [0, 1]
                [double]$r = ($x -as [double]) / ($ImageWidth - 1)
                [double]$g = ($y -as [double]) / ($ImageHeight - 1)
                [double]$b = 0.25

                # Convert the color to a 32-bit integer
                [int]$ir = $r * 255 -as [int]
                [int]$ig = $g * 255 -as [int]
                [int]$ib = $b * 255 -as [int]
 
                $bitmap.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($ir, $ig, $ib))
            }
        }
        $bitmap.Save($OutputFile, [System.Drawing.Imaging.ImageFormat]::Png)
    }
}
