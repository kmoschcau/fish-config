# vim: foldmethod=marker

# colors {{{1
# color definitions {{{2
set --global materlal_red_300 e57373 #e57373
set --global material_red_500 f44336 #f44336
set --global material_red_600 e53935 #e53935
set --global material_red_A100 ff8a80 #ff8a80
set --global material_red_A200 ff5252 #ff5252
set --global material_blue_600 1e88e5 #1e88e5
set --global material_blue_700 1976d2 #1976d2
set --global material_light_blue_500 03a9f4 #03a9f4
set --global material_light_blue_A100 80d8ff #80d8ff
set --global material_cyan_100 b2ebf2 #b2ebf2
set --global material_cyan_A700 00b8d4 #00b8d4
set --global material_teal_500 009688 #009688
set --global material_green_600 43a047 #43a047
set --global material_green_700 388e3c #388e3c
set --global material_green_A700 00c853 #00c853
set --global material_light_green_600 7cb342 #7cb342
set --global material_yellow_500 ffeb3b #ffeb3b
set --global material_yellow_600 fdd835 #fdd835
set --global material_amber_600 ffb300 #ffb300
set --global material_orange_500 ff9800 #ff9800
set --global material_orange_600 fb8c00 #fb8c00
set --global material_grey_50 fafafa #fafafa
set --global material_grey_100 f5f5f5 #f5f5f5
set --global material_grey_200 eeeeee #eeeeee
set --global material_grey_300 e0e0e0 #e0e0e0
set --global material_grey_400 bdbdbd #bdbdbd
set --global material_grey_500 9e9e9e #9e9e9e
set --global material_grey_700 616161 #616161

# syntax colors for the shell {{{2
set fish_color_normal $material_grey_700
set fish_color_command $material_teal_500
set fish_color_keyword $material_orange_600 --bold
set fish_color_quote $material_green_600
set fish_color_redirection $material_orange_600
set fish_color_end $material_red_600
set fish_color_error $material_red_500 --underline
set fish_color_param $material_orange_500 --italics
# set fish_color_valid_path
# set fish_color_option
set fish_color_comment $material_grey_500
set fish_color_selection --background $material_cyan_100
set fish_color_operator $material_orange_600 --bold
set fish_color_escape $material_light_green_600
set fish_color_autosuggestion $material_grey_500
set fish_color_cancel --background $material_grey_200 --italics
set fish_color_search_match --background $material_yellow_500

# completion pager highlights {{{2
set fish_pager_color_progress $material_green_700 --background $material_grey_100 --bold
set fish_pager_color_background --background $material_grey_100
set fish_pager_color_prefix $material_blue_600 --underline --bold
set fish_pager_color_completion $material_grey_700
set fish_pager_color_description $material_grey_500
set fish_pager_color_prefix $material_blue_700 --underline --bold
set fish_pager_color_selected_background --background $material_cyan_100

# cursor shapes for the different vi modes {{{1
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace underscore blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual block
