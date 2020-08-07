Add-Type -AssemblyName System.Web

$playlist = './playlist.xspf'

'<?xml version="1.0" encoding="UTF-8"?>' | Out-File -Encoding UTF8 -FilePath $playlist
'<playlist version="1" xmlns="http://xspf.org/ns/0/">' | Out-File -Append -Encoding UTF8 -FilePath $playlist
'<trackList>' | Out-File -Append -Encoding UTF8 -FilePath $playlist

Get-ChildItem | Where-Object {$_.Extension -EQ ".opus" -AND $_.Extension -NE ".temp.opus"} | `
    Resolve-Path -Relative | ForEach-Object {$_.Replace(".\", "")} | `
    ForEach-Object { `
        $track = [System.Web.HTTPUtility]::UrlEncode($_)
        "<track><location>file:///" + $track + "</location></track>" `
    } | Out-File -Append -Encoding UTF8 -FilePath $playlist

'</trackList>' | Out-File -Append -Encoding UTF8 -FilePath $playlist
'</playlist>' | Out-File -Append -Encoding UTF8 -FilePath $playlist