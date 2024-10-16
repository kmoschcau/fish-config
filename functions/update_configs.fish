function update_configs \
    --description 'Update all configurations in XDG_CONFIG_HOME'
    argparse o/old no-gui -- $argv
    or return

    set base_uri git@github.com:kmoschcau/

    # irregular configs that are cloned with their names as-is
    set irregular_configs global-config home-config

    # configs that have "-config" in their repo name, but should be cloned into
    # dirs like their names listed here
    set configs bat fish fontconfig fzf git glamour nvim ranger tig yamllint wezterm yazi

    # like configs, but these are no longer actively used
    set old_configs alacritty dunst i3 i3blocks picom rofi rubocop terminator tmux

    # like configs, but ones that are only used for GUI apps
    set gui_configs alacritty dunst fontconfig i3 i3blocks picom rofi terminator wezterm

    if not command --query git
        echo 'git is not installed!'
        return 1
    end

    if not set --query XDG_CONFIG_HOME
        echo 'XDG_CONFIG_HOME is not defined!'
        return 2
    end

    if not test -d "$XDG_CONFIG_HOME"
        echo 'XDG_CONFIG_HOME dir does not exist!'
        return 3
    end

    for config_name in $irregular_configs
        echo "Updating $config_name..."
        set dir_name $XDG_CONFIG_HOME/$config_name
        if not test -d "$dir_name"
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

    if set --query _flag_old
        set --append configs $old_configs
    end

    if set --query _flag_no_gui
        for gui_config in $gui_configs
            set --local index (contains --index -- $gui_config $configs)
            if set --query index[1]
                set --erase configs[$index]
            end
        end
    end

    for config_name in $configs
        echo "Updating $config_name-config..."
        set dir_name $XDG_CONFIG_HOME/$config_name
        if not test -d "$dir_name"
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
