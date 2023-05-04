# Raytracing in One Weekend, PowerShell edition

> This project is part of [Project Lemonade](https://rangho.dev/project-lemonade).

Simple path tracer written in PowerShell, based on [Raytracing in One Weekend][1] online book.

## Why PowerShell of all things

Read [this explanation][2] from [Project Lemonade][3] website.

## How to run

First, clone and enter this repository.

```sh
git clone https://github.com/RangHo/powershell-raytracing
cd powershell-raytracing
```

Enter PowerShell, and import the `PSRaytracing` module available in `Sources/` directory.

```powershell
Import-Module .\Sources\PSRaytracing.psm1
```

This module provides `Invoke-Raytracing` cmdlet that renders a scene.
Provide `-ImageWidth` and -`ImageHeight` to set the output image's width and height.

```powershell
Invoke-Raytracing -ImageWidth 160 -ImageHeight 90
```

Since all vector arithmetic is implemented in PowerShell, the rendering process is extremely slow.
Currently there is no plan to accelerate individual calculations via .NET Numerics library.
Speed is not part of the goal of this project, but it may be implemented in the future, after the base implementation is complete.

[1]: https://raytracing.github.io/books/RayTracingInOneWeekend.html
[2]: https://rangho.dev/project-lemonade/#okay-but-why-these-languages
[3]: https://github.com/RangHo/project-lemonade
