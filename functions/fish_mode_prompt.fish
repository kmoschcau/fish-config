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
            set background $material_cyan_A700
            set_color --bold --background $background $material_grey_50
            echo -n ' N '
        case insert
            set background $material_blue_600
            set_color --bold --background $background $material_grey_50
            echo -n ' I '
        case replace
            set background $material_amber_600
            set_color --bold --background $background $material_grey_50
            echo -n ' R '
        case replace_one
            set background $material_amber_600
            set_color --bold --background $background $material_grey_50
            echo -n ' r '
        case visual
            set background $material_cyan_100
            set_color --bold --background $background $material_grey_700
            echo -n ' V '
    end

    # write separator
    set_color $background --background $material_grey_100
    echo -n ''

    # reset colors
    set_color normal
end
