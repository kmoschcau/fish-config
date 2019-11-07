function fish_mode_prompt --description 'Write out the current mode in the prompt'
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
     or test "$fish_key_bindings" = "fish_hybrid_key_bindings"

    # color definitions
    set --local blue_600 1e88e5
    set --local cyan_100 b2ebf2
    set --local cyan_A700 00b8d4
    set --local amber_600 ffb300
    set --local blue_grey_50 eceff1
    set --local blue_grey_100 cfd8dc
    set --local blue_grey_700 455a64
    set --local background

    # switch on current mode
    switch $fish_bind_mode
      case default
        set background $cyan_A700
        set_color --bold --background $background $blue_grey_50
        echo -n ' N '
      case insert
        set background $blue_600
        set_color --bold --background $background $blue_grey_50
        echo -n ' I '
      case replace_one
        set background $amber_600
        set_color --bold --background $background $blue_grey_50
        echo -n ' R '
      case visual
        set background $cyan_100
        set_color --bold --background $background $blue_grey_700
        echo -n ' V '
    end

    # write seperator
    set_color $background --background $blue_grey_100
    echo -n ''

    # reset colors
    set_color normal
  end
end
