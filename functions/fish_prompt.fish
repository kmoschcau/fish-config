function fish_prompt --description 'Write out the prompt'
  # get the status first, so it is not overwritten by anything in the prompt
  # function
  set --local last_status $status

  # separator color variables
  set --local sep_fg $material_grey_100
  set --local sep_bg normal

  # write the hostname, if connected via ssh
  if set --query SSH_CLIENT; or set --query SSH_TTY
    set sep_bg $material_orange_500
    set_color $sep_fg --background $sep_bg
    echo -n ''
    set_color $material_grey_50
    printf ' %s ' (hostname)
    set sep_fg $material_orange_500
  end

  # write number of jobs, if any
  if jobs --quiet
    set sep_bg $material_light_blue_500
    set_color $sep_fg --background $sep_bg
    echo -n ''
    set_color $material_grey_50
    printf ' %d ' (jobs | wc --lines)
    set sep_fg $material_light_blue_500
  end

  # write current working directory
  set sep_bg $material_grey_400
  set_color $sep_fg --background $sep_bg
  echo -n ''
  set_color $material_grey_50
  printf ' %s ' (prompt_pwd)
  set sep_fg $material_grey_400

  # write git status if not empty
  set --local git_status (fish_git_prompt)
  if test $status -eq 0 -a -n "$git_status"
    set sep_bg $material_grey_700
    set_color $sep_fg --background $sep_bg
    echo -n ''
    set_color $material_grey_50
    echo -n $git_status
    set sep_fg $material_grey_700
  end

  # write the last status
  if test $last_status -ne 0
    set sep_bg $material_red_500
    set_color $sep_fg --background $sep_bg
    echo -n ''
    set_color $material_grey_50
    echo -n " $last_status "
    set sep_fg $material_red_500
  end

  # write superuser warning
  switch "$USER"
    case root toor
      set sep_bg $material_orange_500
      set_color $sep_fg --background $sep_bg
      echo -n ''
      set_color $material_grey_50
      echo -n ' root '
      set sep_fg $material_orange_500
  end

  # write final separator
  set sep_bg normal
  set_color $sep_fg --background $sep_bg
  echo -n ''

  # reset colors and add some padding
  set_color normal
  echo -n ' '
end
