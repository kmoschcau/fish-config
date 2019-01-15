function update_configs \
         --description 'Update all configurations in XDG_CONFIG_HOME'
  set base_uri git@bitbucket.org:kmoschcau/
  set home_config home-config
  set configs Code compton fish git i3 i3blocks nvim powerline ranger rofi \
              terminator tig

  if not command -v git > /dev/null ^ /dev/null
    echo 'git is not installed!'
    return 1
  end

  if not set --query XDG_CONFIG_HOME
    echo 'XDG_CONFIG_HOME is not defined!'
    return 2
  end

  if not test -d $XDG_CONFIG_HOME
    echo 'XDG_CONFIG_HOME dir does not exist!'
    return 3
  end

  begin
    echo "Updating $home_config..."
    set dir_name $XDG_CONFIG_HOME/$home_config
    if not test -d $dir_name
      echo "No $home_config repository, cloning..."
      git clone $base_uri$home_config.git $dir_name
    else
      echo "Existing $home_config repository, updating..."
      pushd $dir_name
      git fetch --prune; and git pull
      popd
    end
    echo "Updated $home_config."
  end

  for config_name in $configs
    echo "Updating $config_name-config..."
    set dir_name $XDG_CONFIG_HOME/$config_name
    if not test -d $dir_name
      echo "No $config_name repository, cloning..."
      git clone $base_uri$config_name-config.git $dir_name
    else
      echo "Existing $config_name repository, updating..."
      pushd $dir_name
      git fetch --prune; and git pull
      popd
    end
    echo "Updated $config_name-config."
  end
end
