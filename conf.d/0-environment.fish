# personal file for fish environment variables

# define variables for the XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
set --export XDG_CONFIG_HOME "$HOME/.config"
set --export XDG_DATA_HOME "$HOME/.local/share"

# set the SHELL variable to fish, if it isn't already set
if test -z "$SHELL"
    set --export SHELL (which fish)
end

# check if the java default directory exists
if test -d /usr/lib/jvm/default
    # set the JAVA_HOME var
    set --export JAVA_HOME /usr/lib/jvm/default
end

# check if .local/bin exists
if test -d "$HOME/.local/bin"
    # add user's .local/bin to path for compatibility with systemd
    fish_add_path --path "$HOME/.local/bin"
end

# check if cargo is installed
if test -d "$HOME/.cargo"
    # add rustup (Rust version and package manager) to path
    fish_add_path --path "$HOME/.cargo/bin"
end

# check if dotnet is installed
if test -d "$HOME/.dotnet"
    # add dotnet tools to path
    fish_add_path --path "$HOME/.dotnet/tools"
end

# check if goenv is installed
if test -d "$HOME/.goenv"
    # create GOENV_ROOT
    set --export GOENV_ROOT "$HOME/.goenv"
    # add GOENV_ROOT binaries to PATH
    fish_add_path --path "$GOENV_ROOT/bin"
    # load goenv
    status --is-interactive; and goenv init - | source
end

# check if jenv is installed
if test -d "$HOME/.jenv"
    # create JENV_ROOT
    set --export JENV_ROOT "$HOME/.jenv"
    # add JENV_ROOT binaries to PATH
    fish_add_path --path "$JENV_ROOT/bin"
    # load jenv
    status --is-interactive; and jenv init - | source
end

# check if nodenv is installed
if test -d "$HOME/.nodenv"
    # create NODENV_ROOT
    set --export NODENV_ROOT "$HOME/.nodenv"
    # add NODENV_ROOT binaries to PATH
    fish_add_path --path "$NODENV_ROOT/bin"
    # load nodenv
    status --is-interactive; and nodenv init - | source
end

# check if phpenv is installed
if test -d "$HOME/.phpenv"
    # create PHPENV_ROOT
    set --export PHPENV_ROOT "$HOME/.phpenv"
    # add PHPENV_ROOT binaries to PATH
    fish_add_path --path "$PHPENV_ROOT/bin"
    # load phpenv
    status --is-interactive; and phpenv init - | source
end

# check if pyenv is installed
if test -d "$HOME/.pyenv"
    # create PYENV_ROOT
    set --export PYENV_ROOT "$HOME/.pyenv"
    # add PYENV_ROOT binaries to PATH
    fish_add_path --path "$PYENV_ROOT/bin"
    # enabled dynamic Python libraries
    set --export PYTHON_CONFIGURE_OPTS --enable-shared
    # let the pyenv output add to the path
    pyenv init --path | source
    # load pyenv
    status --is-interactive; and pyenv init - | source
end

# check if rbenv is installed
if test -d "$HOME/.rbenv"
    # create RBENV_ROOT
    set --export RBENV_ROOT "$HOME/.rbenv"
    # add RBENV_ROOT binaries to PATH
    fish_add_path --path "$RBENV_ROOT/bin"
    # load rbenv
    status --is-interactive; and rbenv init - fish | source
end

# check if yarn (node package manager) is installed
if test -d "$HOME/.yarn"
    # add yarn binaries to PATH
    fish_add_path --path "$HOME/.yarn/bin"
    # add node modules binaries to PATH
    fish_add_path --path "$HOME/.config/yarn/global/node_modules/.bin"
end

# check if zoxide is installed
if command --query zoxide
    # load zoxide
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
