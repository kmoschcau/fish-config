function bw_password_prompt \
    --description 'Create a prompt for read on Bitwarden unlock'

    # separator color variables
    set --local sep_fg $material_grey_100
    set --local sep_bg normal

    # print the prompt for
    set sep_bg $material_grey_400
    set_color $sep_fg --background $sep_bg
    echo -n ''
    set_color $material_grey_50
    echo -n ' Bitwarden Password '
    set sep_fg $material_grey_400

    set sep_bg normal
    set_color $sep_fg --background $sep_bg
    echo -n ' '
end
