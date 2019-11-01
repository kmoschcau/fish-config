function update_configs \
         --description 'Update all configurations in XDG_CONFIG_HOME'

  argparse --name=update_configs 'h/help' 's-https' -- $argv; or return

  if set --query _flag_help
    echo -e \
         '\n' \
         '\tupdate_configs\n' \
         '\n' \
         '    Flags\n' \
         '\t( -h | --help ) -> Show this help.\n' \
         '\t( --https )     -> Use https protocol instead of git for new repos.'
    return
  end

  if set --query _flag_https
    set base_uri https://kmoschcau@bitbucket.org/kmoschcau/
  else
    set base_uri git@bitbucket.org:kmoschcau/
  end

  set irregular_configs global-config home-config
  set configs Code compton dunst fish fzf git i3 i3blocks nvim powerline \
              ranger rofi rubocop terminator tig

  if not command -v git > /dev/null 2> /dev/null
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

  for config_name in $irregular_configs
    echo "Updating $config_name..."
    set dir_name $XDG_CONFIG_HOME/$config_name
    if not test -d $dir_name
      echo "No $config_name repository, cloning..."
      git clone $base_uri$config_name.git $dir_name
    else
      echo "Existing $config_name repository, updating..."
      pushd $dir_name
      git fetch --prune; and git pull
      popd
    end
    echo "Updated $config_name."
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
