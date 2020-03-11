# Sample script to install Python and pip under Windows
# Authors: Olivier Grisel, Jonathan Helmus and Kyle Kastner
# License: CC0 1.0 Universal: http://creativecommons.org/publicdomain/zero/1.0/

# Adapted from VisPy

# Mesa DLLs found linked from:
#     http://qt-project.org/wiki/Cross-compiling-Mesa-for-Windows
# to:
#     http://sourceforge.net/projects/msys2/files/REPOS/MINGW/x86_64/mingw-w64-x86_64-mesa-10.2.4-1-any.pkg.tar.xz/download
# then updated to newer version:
#     https://sourceforge.net/projects/msys2/files/REPOS/MINGW/x86_64/mingw-w64-x86_64-mesa-20.0.1-1-any.pkg.tar.xz/download

function CopyMesaOpenGL ($architecture) {
    # if ($architecture -eq "32") {
    #     $filepath = "C:\Windows\SysWOW64\opengl32.dll"
    # } else {
    $filepath = "C:\Windows\system32\opengl32.dll"
    #}
    takeown /F $filepath /A
    icacls $filepath /grant "${env:ComputerName}\${env:UserName}:F"
    Write-Host "Copying to " $filepath
    Remove-item -LiteralPath $filepath
    $scriptpath = split-path -parent $MyInvocation.MyCommand.Definition
    $sourcepath = $scriptpath + "\mesa\opengl32_mingw_" + $architecture + ".dll"
    Copy-Item $sourcepath -Destination $filepath
}

function main () {
    CopyMesaOpenGL "64"
}

main
