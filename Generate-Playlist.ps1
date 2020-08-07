Get-ChildItem | Where-Object {$_.Extension -EQ ".opus" -AND $_.Extension -NE ".temp.opus"} | `
    Resolve-Path -Relative | ForEach-Object {$_.Replace(".\", "")} | `
    #ForEach-Object {$_.Replace("\", "/")} | `
    Out-File -Encoding UTF8 -FilePath "./playlist.m3u"
