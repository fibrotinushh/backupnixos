fish_add_path ~/.local/bin

set -g fish_greeting ""

if status is-interactive
    fastfetch
end

set -g water_ice      b8c8d8
set -g water_surface  80a0c0
set -g water_deep     6888a8
set -g water_teal     68a898
set -g water_cyan     60a0a0
set -g water_muted    5890a8
set -g water_dark     5a6078
set -g water_storm    8878a0
set -g water_coral    b06858
set -g water_foam     d0d8e0
set -g water_text     b8c8d8
set -g water_bg       191d2d
set -g water_surface0 2a3848
set -g water_surface1 3a4858
set -g water_overlay  3a4058

set -g fish_color_normal $water_text
set -g fish_color_command $water_muted
set -g fish_color_param $water_surface
set -g fish_color_redirection $water_cyan
set -g fish_color_comment $water_dark
set -g fish_color_error $water_coral
set -g fish_color_end $water_deep
set -g fish_color_escape $water_storm
set -g fish_color_operator $water_teal
set -g fish_color_quote $water_muted
set -g fish_color_autosuggestion $water_dark
set -g fish_color_cwd $water_surface
set -g fish_color_cwd_root $water_coral
set -g fish_color_host $water_deep
set -g fish_color_host_remote $water_teal
set -g fish_color_status $water_coral
set -g fish_color_valid_path $water_teal

set -g fish_pager_color_progress $water_dark
set -g fish_pager_color_prefix $water_deep
set -g fish_pager_color_completion $water_text
set -g fish_pager_color_description $water_dark
set -g fish_pager_color_selected_background $water_surface1
set -g fish_pager_color_selected_prefix $water_muted
set -g fish_pager_color_selected_completion $water_text
set -g fish_pager_color_selected_description $water_text

alias ls "ls --color=auto"
alias ll "ls -la"
alias la "ls -a"
alias grep "grep --color=auto"
alias update "sudo nixos-rebuild switch"
alias edit "sudo nano /etc/nixos/configuration.nix"
alias ff "fastfetch"
alias spin "fetch"

function fish_prompt
    set_color $water_muted
    printf '╭─'
    set_color $water_deep
    printf '%s' $USER
    set_color $water_dark
    printf '@'
    set_color $water_muted
    printf '%s' (hostname)
    set_color $water_dark
    printf ' '
    set_color $water_teal
    printf '%s' (prompt_pwd)
    set_color $water_muted
    printf '\n╰─'
    set_color $water_cyan
    printf ' > '
    set_color normal
end

function fish_right_prompt
    set_color $water_dark
    printf '%s' (date +%H:%M:%S)
    set_color normal
end
