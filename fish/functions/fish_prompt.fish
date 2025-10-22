function fish_prompt
    set -l last_status $status

    set -l normal (set_color normal)
    set -l usercolor (set_color $fish_color_user)

    set -l delim "\$"

    fish_is_root_user; and set delim "#"

    set -l cwd (set_color $fish_color_cwd)
    set -l cwp (set_color $fish_color_cwp)
    # if command -sq cksum
    #         # randomized cwd color
    #         # We hash the physical PWD and turn that into a color. That means directories (usually) get different colors,
    #         # but every directory always gets the same color. It's deterministic.
    #         # We use cksum because 1. it's fast, 2. it's in POSIX, so it should be available everywhere.
    #         set -l shas (pwd -P | cksum | string split -f1 ' ' | math --base=hex | string sub -s 3 | string pad -c 0 -w 6 | string match -ra ..)
    #         set -l col 0x$shas[1..3]
    #
    #         # If the (simplified idea of) luminance is below 120 (out of 255), add some more.
    #         # (this runs at most twice because we add 60)
    #         while test (math 0.2126 x $col[1] + 0.7152 x $col[2] + 0.0722 x $col[3]) -lt 120
    #                 set col[1] (math --base=hex "min(255, $col[1] + 60)")
    #                 set col[2] (math --base=hex "min(255, $col[2] + 60)")
    #                 set col[3] (math --base=hex "min(255, $col[3] + 60)")
    #         end
    #         set -l col (string replace 0x '' $col | string pad -c 0 -w 2 | string join "")
    #
    #         set cwd (set_color $col)
    # end
    set -l mode_color (set_color $fish_color_delim)
    set -l mode ""
    # Do nothing if not in vi mode
    switch $fish_bind_mode
        case default
            # set mode_color (set_color cc3500)
            set mode $delim
        case insert
        # set mode_color (set_color cc3500)
            set mode ">"
        case replace_one
            # set mode_color (set_color green)
            set mode "_"
        case replace
            # set mode_color (set_color cyan)
            set mode "_"
        case visual
            # set mode_color (set_color --bold magenta)
            set mode "|"
    end

    # Prompt status only if it's not 0
    set -l prompt_status
    test $last_status -ne 0; and set prompt_status " "(set_color $fish_color_status)"[$last_status]$normal"

    # Only show host if in SSH or container
    # Store this in a global variable because it's slow and unchanging
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end
            set prompt_host $usercolor$USER$normal@(set_color $fish_color_host)$hostname$normal":"
        end
    end

    # Shorten pwd if prompt is too long
    set -l wd 
    set -l pwd_list (string split "/" (prompt_pwd))
    set -l pwd (prompt_pwd)
    set -l sep 
    if test "$pwd" = "~" -o "$pwd" = "/"
        set sep ""
        set wd (string match -r "/?[^/]*\$" $pwd)
    else
        set sep "/"
        set wd (string match -r "[^/]*\$" $pwd)
    end
    set -l p (string replace -r "/[^/]*\$|^~\$" $sep $pwd)

    set -l delim_col (set_color $fish_color_delim)
    echo -n -s $prompt_host $cwp $p $cwd $wd $normal $prompt_status " " $mode_color $mode $normal " " 
    # $delim_col $delim $normal " "
end
