# HstWB Installer Dialog Module
# -----------------------------
#
# Author: Henrik Noerfjand Stengaard
# Date:   2017-09-18
#
# A powershell module for HstWB Installer with dialog functions.


# print settings
function PrintSettings($hstwb)
{
    Write-Host "Settings"
    Write-Host "  Settings File         : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Paths.SettingsFile + "'")
    Write-Host "  Assigns File          : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Paths.AssignsFile + "'")
    Write-Host "Image"
    Write-Host "  Image Dir             : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Image.ImageDir + "'")
    Write-Host "Workbench"
    Write-Host "  Install Workbench     : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Workbench.InstallWorkbench + "'")
    Write-Host "  Workbench Adf Path    : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Workbench.WorkbenchAdfPath + "'")
    Write-Host "  Workbench Adf Set     : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Workbench.WorkbenchAdfSet + "'")
    Write-Host "Amiga OS 3.9"
    Write-Host "  Install Amiga OS 3.9  : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.AmigaOS39.InstallAmigaOS39 + "'")
    Write-Host "  Install Boing Bags    : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.AmigaOS39.InstallBoingBags + "'")
    Write-Host "  Amiga OS 3.9 Iso File : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.AmigaOS39.AmigaOS39IsoFile + "'")
    Write-Host "Kickstart"
    Write-Host "  Install Kickstart     : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Kickstart.InstallKickstart + "'")
    Write-Host "  Kickstart Rom Path    : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Kickstart.KickstartRomPath + "'")
    Write-Host "  Kickstart Rom Set     : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Kickstart.KickstartRomSet + "'")
    Write-Host "Packages"

    $packageFileNames = @()
    $packageFileNames += $hstwb.Settings.Packages.InstallPackages -split ',' | Where-Object { $_ }

    if ($packageFileNames.Count -gt 0)
    {
        for ($i = 0; $i -lt $packageFileNames.Count;$i++)
        {
            if ($i -eq 0)
            {
                Write-Host "  Install Packages      : " -NoNewline -foregroundcolor "Gray"
            }
            else
            {
                Write-Host "                          " -NoNewline
            }

            $packageFileName = $packageFileNames[$i]
            $package = $hstwb.Packages.Get_Item($packageFileName)

            Write-Host ("'" + $package.Package.Name + " v" + $package.Package.Version + "'")
        }
    }
    else
    {
        Write-Host "  Install Packages      : " -NoNewline -foregroundcolor "Gray"
        Write-Host "None" -foregroundcolor "Yellow"
    }

    Write-Host "WinUAE"
    Write-Host "  WinUAE Path           : " -NoNewline -foregroundcolor "Gray"
    Write-Host ("'" + $hstwb.Settings.Winuae.WinuaePath + "'")
    Write-Host "Installer"
    Write-Host "  Mode                  : " -NoNewline -foregroundcolor "Gray"
    switch ($hstwb.Settings.Installer.Mode)
    {
        "Test" { Write-Host "'Test'" }
        "Install" { Write-Host "'Install'" }
        "BuildSelfInstall" { Write-Host "'Build Self Install'" }
        "BuildPackageInstallation" { Write-Host "'Build Package Installation'" }
    }
}


# enter path
function EnterPath($prompt)
{
    do
    {
        $path = Read-Host $prompt

        if ($path -ne '')
        {
            $path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
        }
        
        if (!(test-path -path $path))
        {
            Write-Error "Path '$path' doesn't exist"
        }
    }
    until ($path -eq '' -or (test-path -path $path))
    return $path
}


# enter choice
function EnterChoice($prompt, $options)
{
    $optionPadding = $options.Count.ToString().Length

    for ($i = 0; $i -lt $options.Count; $i++)
    {
        Write-Host (("{0," + $optionPadding + "}: ") -f ($i + 1)) -NoNewline -foregroundcolor "Gray"
        Write-Host $options[$i]
    }
    Write-Host ""

    do
    {
        Write-Host ("{0}: " -f $prompt) -NoNewline -foregroundcolor "Cyan"
        $choice = [int32](Read-Host)
    }
    until ($choice -ne '' -and $choice -ge 1 -and $choice -le $options.Count)

    return $options[$choice - 1]
}