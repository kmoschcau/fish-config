# personal file for fish environment variables

# define variables for the XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
set --export XDG_CONFIG_HOME "$HOME/.config"
set --export XDG_DATA_HOME "$HOME/.local/share"

# set the SHELL variable to fish, if it isn't already set
if test -z "$SHELL"
    set --export SHELL (which fish)
end

# set up the java default directory
if test -d /usr/lib/jvm/default
    set --export JAVA_HOME /usr/lib/jvm/default
end

# add user's .local/bin to path for compatibility with systemd
if test -d "$HOME/.local/bin"
    fish_add_path --path "$HOME/.local/bin"
end

# set up cargo (rust build tool)
if command --query cargo
    fish_add_path --path "$HOME/.cargo/bin"
end

# set up dotnet tools
if command --query dotnet
    fish_add_path --path "$HOME/.dotnet/tools"
end

# set up goenv
if command --query goenv
    set --export GOENV_ROOT "$HOME/.goenv"
    fish_add_path --path "$GOENV_ROOT/bin"
    status --is-interactive; and goenv init - | source
end

# set up jenv
if command --query jenv
    set --export JENV_ROOT "$HOME/.jenv"
    fish_add_path --path "$JENV_ROOT/bin"
    status --is-interactive; and jenv init - | source
end

# set up luarocks
if command --query luarocks
    set --export LUA_PATH (luarocks path --lr-path)
    set --export LUA_CPATH (luarocks path --lr-cpath)
    fish_add_path --path "$HOME/.luarocks/bin"
end

# set up nodenv
if command --query nodenv
    set --export NODENV_ROOT "$HOME/.nodenv"
    fish_add_path --path "$NODENV_ROOT/bin"
    status --is-interactive; and nodenv init - | source
end

# set up phpenv
if command --query phpenv
    set --export PHPENV_ROOT "$HOME/.phpenv"
    fish_add_path --path "$PHPENV_ROOT/bin"
    status --is-interactive; and phpenv init - | source
end

# set up pyenv
if command --query pyenv
    set --export PYENV_ROOT "$HOME/.pyenv"
    fish_add_path --path "$PYENV_ROOT/bin"
    set --export PYTHON_CONFIGURE_OPTS --enable-shared
    pyenv init --path | source
    status --is-interactive; and pyenv init - | source
end

# set up rbenv
if command --query rbenv
    set --export RBENV_ROOT "$HOME/.rbenv"
    fish_add_path --path "$RBENV_ROOT/bin"
    status --is-interactive; and rbenv init - fish | source
end

# set up yarn (node package manager)
if command --query yarn
    # add yarn binaries to PATH
    fish_add_path --path "$HOME/.yarn/bin"
    # add node modules binaries to PATH
    fish_add_path --path "$HOME/.config/yarn/global/node_modules/.bin"
end

# set up zoxide
if command --query zoxide
    status --is-interactive; and zoxide init fish | source
end

# add user's private bin to PATH, if it exists
fish_add_path --path "$HOME/bin"

# remove duplicate entries from path
deduplicate_path

# add default settings for fzf, if it is installed
if command --query fzf
    set --export FZF_DEFAULT_OPTS (cat $HOME/.config/fzf/default_opts.txt)

    if command --query rg
        set --export FZF_DEFAULT_COMMAND 'rg --files --hidden --glob !/.git/'
    else if command --query ag
        set --export FZF_DEFAULT_COMMAND 'ag --files-with-matches --hidden'
    else
        set --export FZF_DEFAULT_COMMAND 'find -type f'
    end
end

# grep default colors
set --export GREP_COLORS (string join ':'\
                                      'sl='\
                                      'cx='\
                                      'ms=48;2;255;235;59'\
                                      'mc=48;2;255;235;59'\
                                      'fn=38;2;235;239;241;48;2;69;90;100'\
                                      'ln=38;2;96;125;139;48;2;144;164;174'\
                                      'bn=38;2;96;125;139;48;2;144;164;174'\
                                      'se=38;2;96;125;139;48;2;144;164;174')

if command --query ksshaskpass
    set --export SSH_ASKPASS ksshaskpass
    set --export SSH_ASKPASS_REQUIRE prefer
end

# set the default Glamour style
set --export GLAMOUR_STYLE ~/.config/glamour/material.json

# set the LAUNCH_EDITOR variable for vite's inspector plugin
command --query launch_editor
and set --export LAUNCH_EDITOR launch_editor

# editor used by `bundle open <gem>`
set --export BUNDLER_EDITOR nvim
# editor used as "line editor"
set --export EDITOR nvim
# editor tried before EDITOR as "visual editor"
set --export VISUAL nvim
# editor for systemd
set --export SYSTEMD_EDITOR nvim

# Configure pinentry to use the correct TTY
if command --query gpg-connect-agent
    set --export GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null
end
