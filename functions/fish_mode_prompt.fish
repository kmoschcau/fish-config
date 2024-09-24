function fish_mode_prompt \
    --description 'Write out the current mode in the prompt.'

    if not contains $fish_key_bindings \
            fish_vi_key_bindings fish_hybrid_key_bindings

        return
    end

    # switch on current mode
    set --local background
    switch $fish_bind_mode
        case default
            set background $fish_prompt_color_mode_normal_bg
            set_color \
                $fish_prompt_color_mode_normal_decorations \
                --background $background \
                $fish_prompt_color_mode_normal_fg
            echo -n ' N '
        case insert
            set background $fish_prompt_color_mode_insert_bg
            set_color \
                $fish_prompt_color_mode_insert_decorations \
                --background $background \
                $fish_prompt_color_mode_insert_fg
            echo -n ' I '
        case replace
            set background $fish_prompt_color_mode_replace_bg
            set_color \
                $fish_prompt_color_mode_replace_decorations \
                --background $background \
                $fish_prompt_color_mode_replace_fg
            echo -n ' R '
        case replace_one
            set background $fish_prompt_color_mode_replace_bg
            set_color \
                $fish_prompt_color_mode_replace_decorations \
                --background $background \
                $fish_prompt_color_mode_replace_fg
            echo -n ' r '
        case visual
            set background $fish_prompt_color_mode_visual_bg
            set_color \
                $fish_prompt_color_mode_visual_decorations \
                --background $background \
                $fish_prompt_color_mode_visual_fg
            echo -n ' V '
    end

    # write separator
    set_color $background --background $material_grey_100
    echo -n ''

    # reset colors
    set_color normal
end
