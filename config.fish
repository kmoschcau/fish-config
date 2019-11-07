# vim: foldmethod=marker

# enable vi mode in fish
if status --is-interactive
   and status --is-login
  fish_vi_key_bindings
end

# Set the syntax colors for the shell
set fish_color_normal         455a64
set fish_color_command        fb8c00 --bold
set fish_color_quote          43a047
set fish_color_redirection    fbc02d
set fish_color_end            fb8c00
set fish_color_error          f44336
set fish_color_param          00acc1
set fish_color_comment        78909c
set fish_color_match          80cbc4
set fish_color_selection      --background=b2ebf2
set fish_color_search_match   --background=ffeb3b
set fish_color_operator       26a69a --bold
set fish_color_escape         7cb342
set fish_color_autosuggestion 78909c
set fish_color_cancel         --background=b0bec5 --italics

# Set the prompt highlights
set fish_color_cwd  eceff1 --background=455a64
set fish_color_user eceff1 --background=90a4ae
set fish_color_host eceff1 --background=90a4ae

# Set the completion pager highlights
set fish_pager_color_prefix      1e88e5 --underline --bold
set fish_pager_color_completion  455a64
set fish_pager_color_description 78909c
set fish_pager_color_progress    388e3c --bold
set fish_pager_color_secondary   --backbround=cfd8dc

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block
