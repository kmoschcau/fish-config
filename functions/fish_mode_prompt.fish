function fish_mode_prompt \
    --description 'Write out the current mode in the prompt.'

    if not contains $fish_key_bindings \
            fish_vi_key_bindings fish_hybrid_key_bindings

        return
    end

    # get the status first, so it is not overwritten by anything in the prompt
    # function
    set --local last_status $status

    # send operating system command (OSC) escape sequence for command finished
    # ("FTCS_COMMAND_FINISHED")
    if test "$last_status" -ne 0
        printf "\e]133;D;$last_status\e\\"
    else
        printf "\e]133;D\e\\"
    end

    # send OSC for cwd
    if command --query wslpath
        printf "\e]9;9;%s\e\\" (wslpath -w $PWD)
    else if command --query pwd
        printf "\e]9;9;%s\e\\" (pwd)
    end

    # send OSC for prompt start
    # ("FTCS_PROMPT")
    printf "\e]133;A\e\\"

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
    echo -n $fish_prompt_separator_section_top_left

    # reset colors
    set_color normal
end
