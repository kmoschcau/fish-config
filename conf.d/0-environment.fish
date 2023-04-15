# personal file for fish environment variables

# define variables for the XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
set --export XDG_CONFIG_HOME "$HOME/.config"
set --export XDG_DATA_HOME "$HOME/.local/share"

# set the SHELL variable to fish, if it isn't already set
if test -z $SHELL
    set --export SHELL (which fish)
end

# check if the java default directory exists
if test -d /usr/lib/jvm/default
    # set the JAVA_HOME var
    set --export JAVA_HOME /usr/lib/jvm/default
end

# add user's .local/bin to path for compatibility with systemd
if test -d "$HOME/.local/bin"; and not contains "$HOME/.local/bin" $PATH
    set --export PATH "$HOME/.local/bin" $PATH
end

# add rustup (Rust version and package manager) to path
if test -d "$HOME/.cargo/bin"; and not contains "$HOME/.cargo/bin" $PATH
    set --export PATH "$HOME/.cargo/bin" $PATH
end

# check if pyenv is installed
if test -d "$HOME/.pyenv"
    # create PYENV_ROOT
    set --export PYENV_ROOT "$HOME/.pyenv"
    # add PYENV_ROOT binaries to PATH
    if test -d "$PYENV_ROOT/bin"; and not contains "$PYENV_ROOT/bin" $PATH
        set --export PATH "$PYENV_ROOT/bin" $PATH
    end
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
    if test -d "$RBENV_ROOT/bin"; and not contains "$RBENV_ROOT/bin" $PATH
        set --export PATH "$RBENV_ROOT/bin" $PATH
    end
    # load rbenv
    status --is-interactive; and rbenv init - fish | source
end

# check if nodenv is installed
if test -d "$HOME/.nodenv"
    # create NODENV_ROOT
    set --export NODENV_ROOT "$HOME/.nodenv"
    # add NODENV_ROOT binaries to PATH
    if test -d "$NODENV_ROOT/bin"; and not contains "$NODENV_ROOT/bin" $PATH
        set --export PATH "$NODENV_ROOT/bin" $PATH
    end
    # load nodenv
    status --is-interactive; and nodenv init - | source
end

# check if jenv is installed
if test -d "$HOME/.jenv"
    # create JENV_ROOT
    set --export JENV_ROOT "$HOME/.jenv"
    # add JENV_ROOT binaries to PATH
    if test -d "$JENV_ROOT/bin"; and not contains "$JENV_ROOT/bin" $PATH
        set --export PATH "$JENV_ROOT/bin" $PATH
    end
    # load jenv
    status --is-interactive; and jenv init - | source
end

# check if yarn (node package manager) is installed
if test -d "$HOME/.yarn"
    # add yarn binaries to PATH
    if test -d "$HOME/.yarn/bin"; and not contains "$HOME/.yarn/bin" $PATH
        set --export PATH "$HOME/.yarn/bin" $PATH
    end
    # add node modules binaries to PATH
    if test -d "$HOME/.config/yarn/global/node_modules/.bin"; and not contains "$HOME/.config/yarn/global/node_modules/.bin" $PATH
        set --export PATH "$HOME/.config/yarn/global/node_modules/.bin" $PATH
    end
end

# add user's private bin to PATH, if it exists
if test -d "$HOME/bin"; and not contains "$HOME/bin" $PATH
    set --export PATH "$HOME/bin" $PATH
end

# remove duplicate entries from path
deduplicate_path

# add default settings for fzf, if it is installed
if command --search fzf > /dev/null 2> /dev/null
    set --export FZF_DEFAULT_OPTS (cat $HOME/.config/fzf/default_opts.txt)

    if command --search rg > /dev/null 2> /dev/null
        set --export FZF_DEFAULT_COMMAND 'rg --files --hidden --glob !/.git/'
    else if command --search ag > /dev/null 2> /dev/null
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

if command --search ksshaskpass > /dev/null 2> /dev/null
    set --export SSH_ASKPASS ksshaskpass
    set --export SSH_ASKPASS_REQUIRE prefer
end

# set the default Glamour style
set --export GLAMOUR_STYLE ~/.config/glamour/material.json

# editor used by `bundle open <gem>`
set --export BUNDLER_EDITOR nvim
# editor used as "line editor"
set --export EDITOR nvim
# editor tried before EDITOR as "visual editor"
set --export VISUAL nvim
# editor for systemd
set --export SYSTEMD_EDITOR nvim

# set up ssh-agent
fish_ssh_agent

# Configure pinentry to use the correct TTY
set --export GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
