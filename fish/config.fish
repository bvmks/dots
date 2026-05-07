if status is-interactive
    # Commands to run in interactive sessions can go here

    alias ..='cd ..'
    alias ...='cd ../..'
    alias .3='cd ../../..'
    alias .4='cd ../../../..'
    alias .5='cd ../../../../..'

    # set -g fish_sequence_key_delay_ms 300 

    function yank-to-clipboard
        set text (commandline -k) 
        echo -n $text | xclip -selection clipboard
    end

    function yank-line-to-clipboard
        set -l all (commandline)
        set -l cur (commandline -L)
        set -l lines (string split0 \n -- $all)
        set -l line $lines[$cur]
        echo -n $line | xclip -selection clipboard
    end

    #binds
    # bind space,p 'set -g fish_cursor_end_mode exclusive' forward-char 'set -g fish_cursor_end_mode inclusive' fish_clipboard_paste
    # bind space,P fish_clipboard_paste
    # bind -M insert space,p 'set -g fish_cursor_end_mode exclusive' forward-char 'set -g fish_cursor_end_mode inclusive' fish_clipboard_paste
    # bind -M insert space,P fish_clipboard_paste
    # bind -M visual space,p fish_clipboard_paste

    bind alt-p up-or-search
    bind -M insert alt-p up-or-search
    bind -M visual alt-p up-or-search
    bind alt-n down-or-search
    bind -M insert alt-n down-or-search
    bind -M visual alt-n down-or-search

    # bind space,s complete-and-search
    # bind -M insert space,s complete-and-search

    # bind space,r history-pager
    # bind -M insert space,r history-pager
    bind ctrl-r history-pager
    bind -M insert ctrl-r history-pager

    # bind -M insert space,w backward-kill-path-component
    bind alt-w backward-kill-path-component
    bind alt-e execute
    bind -M insert alt-e execute
    bind ctrl-l __fish_list_current_token
    bind -M insert ctrl-l __fish_list_current_token
    bind -M insert ctrl-e execute
    bind j down-line    
    bind k up-line 

    # bind alt-n accept-autosuggestion
    # bind -M insert alt-n accept-autosuggestion

    bind s forward-single-char forward-single-char backward-word kill-word repaint
    
    # bind -M insert space,u undo
    bind alt-u redo
    bind ctrl-l down-line

    bind ctrl-alt-h backward-word
    bind ctrl-alt-l forward-word
    bind ctrl-x 'commandline | xclip -selection clipboard; commandline -f clear-commandline' 
    bind -M insert ctrl-x 'commandline | xclip -selection clipboard; commandline -f clear-commandline' 

    # bind space,d,d kill-whole-line and yank-to-clipboard
    #
    # bind space,y,y yank-line-to-clipboard
    # bind -M insert space,y,y yank-line-to-clipboard
    # bind -M visual space,y,y yank-line-to-clipboard 

    # bind space,y fish_clipboard_copy
    # bind -M insert space,y fish_clipboard_copy
    bind -M visual -m default space,y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind -M visual -m default space,y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'

    bind alt-c -m insert clear-commandline repaint
    bind -M insert alt-c clear-commandline repaint

    bind alt-i cancel repaint
    bind alt-a cancel repaint
    bind -M insert -m default alt-i cancel repaint
    bind -M insert -m default alt-a cancel repaint
    bind -M replace -m default alt-i cancel repaint
    bind -M replace -m default alt-a cancel repaint
    bind -M replace_one -m default alt-i rcancel epaint
    bind -M replace_one -m default alt-a rcancel epaint
    bind -M visual -m default alt-i end-selection cancel repaint
    bind -M visual -m default alt-a end-selection cancel repaint

    bind -M default d,x kill-line
    
    bind alt-w nextd-or-forward-word
    bind alt-b prevd-or-backward-word
    bind -M insert alt-w nextd-or-forward-word
    bind -M insert alt-b prevd-or-backward-word

    bind -M insert alt-l forward-char
    bind -M insert alt-h backward-char
    bind alt-l forward-char
    bind alt-h backward-char

    bind alt-k up-or-search
    bind alt-j down-or-search
    bind -M insert alt-j down-or-search
    bind -M insert alt-k up-or-search

    # bind space,g 'commandline -a " | grep";' 
    # bind -M input space,g 'commandline -a " | grep"' 
end 
