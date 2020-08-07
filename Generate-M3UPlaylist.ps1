function Generate-M3UPlaylist {
    param(
        [System.IO.DirectoryInfo] $directory,
        [string] $playlistFileName = "",
        [string] $pattern = "*.opus"
    )

    # make sure we add m3u as an extension
    if ( "$playlistFileName" -eq "" ) {
        $playlistFileName = $directory.Name + ".m3u"
    }
    elseif ( ! $playlistFileName.EndsWith("m3u") ) {
        $playlistFileName = "$playlistFileName.m3u"
    }

    # store relative paths in the same directory
    if ( ! [System.IO.Path]::IsPathRooted($playlistFileName) ) {
        $playlistFileName = Join-Path -Path $directory -ChildPath $playlistFileName
    }

    # remove old file
    if ( Test-Path $playlistFileName -PathType Leaf ) {
        Remove-Item $playlistFileName
    }

    # only read mp3 files
    if ( ! $pattern.EndsWith(".opus") ) {
        $pattern = "$pattern*.opus"
    }

    # write m3u
    $directory.GetFiles($pattern) |
        ForEach-Object { $_.Name } | 
        Sort-Object |
        Out-File -Encoding UTF8 -FilePath $playlistFileName
}