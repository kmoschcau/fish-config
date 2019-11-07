function bw_password_prompt \
         --description 'Create a prompt for read on Bitwarden unlock'
  # color definitions
  set --local blue_grey_50 eceff1
  set --local blue_grey_100 cfd8dc
  set --local blue_grey_300 90a4ae

  # separator color variables
  set --local sep_fg $blue_grey_100
  set --local sep_bg normal

  # print the prompt for
  set sep_bg $blue_grey_300
  set_color $sep_fg --background $sep_bg
  echo -n ''
  set_color $blue_grey_50
  echo -n ' Bitwarden Password '
  set sep_fg $blue_grey_300

  set sep_bg normal
  set_color $sep_fg --background $sep_bg
  echo -n ' '
end
