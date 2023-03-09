function link_home_config --description 'Create links to home-config files, if they do not exist'
  set home_config home-config
  set file_names .aprc .bash_aliases .bash_environment .bashrc .gemrc .inputrc \
                 .irbrc .pam_environment .profile .xinitrc .xinputrc

  if not set --query XDG_CONFIG_HOME
    echo 'XDG_CONFIG_HOME is not defined!'
    return 1
  end

  if not test -d $XDG_CONFIG_HOME
    echo 'XDG_CONFIG_HOME dir does not exist!'
    return 2
  end

  set home_config_path $XDG_CONFIG_HOME/$home_config
  if not test -d $home_config_path
    echo "$home_config_path dir does not exist!"
    return 3
  end

  for file_name in $file_names
    echo "Creating link for $file_name..."
    set target $home_config_path/$file_name
    set link_name $HOME/$file_name
    if not test -e $target
      echo "$target does not exist! Skipping it."
    else
      ln --force --interactive --symbolic $target $link_name
    end
  end

  mkdir --parents $HOME/.gnupg
  ln --force --interactive --symbolic $home_config_path/gpg-agent.conf\
    $HOME/.gnupg/gpg-agent.conf
end
