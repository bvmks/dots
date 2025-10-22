function setwp
    set wallpapers ~/media/pics/wallpapers

    set files (ls $wallpapers/*.png)

    set names
    for f in $files
        set -a names (basename $f .png)
    end

    set choice (printf "%s\n" $names | fuzzel --dmenu)

    if test -n "$choice"
        for f in $files
            if test (basename $f .png) = $choice
                swww img $f --transition-type fade --transition-duration 1
                break
            end
        end
    end
end
