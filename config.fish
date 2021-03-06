# vim: foldmethod=marker

# enable vi mode in fish
if status --is-interactive
   and status --is-login
  fish_vi_key_bindings
end

# colors {{{1
# color definitions {{{2
set --local red_500         f44336
set --local red_600         e53935
set --local blue_600        1e88e5
set --local blue_700        1976d2
set --local cyan_100        b2ebf2
set --local teal_500        009688
set --local green_600       43a047
set --local green_700       388e3c
set --local light_green_600 7cb342
set --local yellow_500      ffeb3b
set --local amber_600       ffb300
set --local orange_500      ff9800
set --local orange_600      fb8c00
set --local grey_50         fafafa
set --local grey_100        f5f5f5
set --local grey_200        eeeeee
set --local grey_300        e0e0e0
set --local grey_500        9e9e9e
set --local grey_700        616161

# syntax colors for the shell {{{2
set fish_color_normal         $grey_700
set fish_color_keyword        $orange_600 --bold
set fish_color_command        $teal_500
set fish_color_quote          $green_600
set fish_color_redirection    $orange_600
set fish_color_end            $red_600
set fish_color_error          $red_500 --underline
set fish_color_param          $orange_500 --italics
set fish_color_comment        $grey_500
set fish_color_selection      --background $cyan_100
set fish_color_search_match   --background $yellow_500
set fish_color_operator       $orange_600 --bold
set fish_color_escape         $light_green_600
set fish_color_autosuggestion $grey_500
set fish_color_cancel         --background $grey_200 --italics

# prompt highlights {{{2
set fish_color_cwd         $grey_50 --background $grey_700
set fish_color_user        $grey_50 --background $grey_300
set fish_color_host        $grey_50 --background $grey_300
set fish_color_host_remote $grey_50 --background $amber_600

# completion pager highlights {{{2
set fish_pager_color_progress             $green_700 --background $grey_100 --bold
set fish_pager_color_background           --background $grey_100
set fish_pager_color_prefix               $blue_600 --underline --bold
set fish_pager_color_completion           $grey_700
set fish_pager_color_description          $grey_500
set fish_pager_color_prefix               $blue_700 --underline --bold
set fish_pager_color_selected_background  --background $cyan_100

# cursor shapes for the different vi modes {{{1
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block
