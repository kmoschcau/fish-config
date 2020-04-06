function bw_password_prompt \
         --description 'Create a prompt for read on Bitwarden unlock'
  # color definitions
  set --local grey_50 fafafa
  set --local grey_100 f5f5f5
  set --local grey_400 bdbdbd

  # separator color variables
  set --local sep_fg $grey_100
  set --local sep_bg normal

  # print the prompt for
  set sep_bg $grey_400
  set_color $sep_fg --background $sep_bg
  echo -n ''
  set_color $grey_50
  echo -n ' Bitwarden Password '
  set sep_fg $grey_400

  set sep_bg normal
  set_color $sep_fg --background $sep_bg
  echo -n ' '
end
