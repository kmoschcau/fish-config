function update_configs \
         --description 'Update all configurations in XDG_CONFIG_HOME'

  argparse --name=update_configs 'h/help' -- $argv; or return

  if set --query _flag_help
    echo -e \
         'update_configs\n' \
         '    Flags\n' \
         '\t( -h | --help ) -> Show this help and exit.\n' \
         '\t( --https )     -> Use https protocol instead of git for new repos.'
    return
  end

  set base_uri git@github.com:kmoschcau/

  set irregular_configs global-config home-config
  set configs alacritty bat dunst fish fzf git glamour i3 i3blocks nvim picom \
              ranger rofi rubocop terminator tig tmux

  if not command -v git &> /dev/null
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
      git fetch --prune --prune-tags; and git pull
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
      git fetch --prune --prune-tags; and git pull
      popd
    end
    echo "Updated $config_name-config."
  end
end
