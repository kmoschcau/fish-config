# personal file for fish environment variables

# define variables for the XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"

# set the SHELL variable to fish, if it isn't already set
if [ -z $SHELL ]
  set -x SHELL (which fish)
end

# add user's .local/bin to path for compatibility with systemd
if [ -d "$HOME/.local/bin" ]; and not contains "$HOME/.local/bin" $PATH
  set -x PATH "$HOME/.local/bin" $PATH
end

# check if Eclipse Oxygen is installed
if [ -d "$HOME/eclipse/oxygen/eclipse" ]
  # create ECLIPSE_HOME
  set -x ECLIPSE_HOME "$HOME/eclipse/oxygen/eclipse"
  # check if Eclim plugin is installed
  if [ -d "$ECLIPSE_HOME/plugins/org.eclim_2.7.0" ];
     and not contains "$ECLIPSE_HOME/plugins/org.eclim_2.7.0" $PATH
    # add Eclim binary directory to PATH
    set -x PATH "$ECLIPSE_HOME/plugins/org.eclim_2.7.0/bin" $PATH
  end
end

# check if rustup (Rust version and package manager) is installed
if [ -d "$HOME/.cargo" ]; and not contains "$HOME/.cargo/bin" $PATH
  # add rustup (Rust version and package manager) to path
  set -x PATH "$HOME/.cargo/bin" $PATH
end

# check if pyenv is installed
if [ -d "$HOME/.pyenv" ]
  # create PYENV_ROOY
  set -x PYENV_ROOT "$HOME/.pyenv"
  # add PYENV_ROOT binaries to PATH
  if not contains "$PYENV_ROOT/bin" $PATH
    set -x PATH "$PYENV_ROOT/bin" $PATH
  end
  # enabled dynamic Python libraries
  set -x PYTHON_CONFIGURE_OPTS '--enable-shared'
  # load pyenv
  status --is-interactive; and pyenv init - | source
end

# check if rbenv is installed
if [ -d "$HOME/.rbenv" ]
  # create RBENV_ROOT
  set -x RBENV_ROOT "$HOME/.rbenv"
  # add RBENV_ROOT binaries to PATH
  if not contains "$RBENV_ROOT/bin" $PATH
    set -x PATH "$RBENV_ROOT/bin" $PATH
  end
  # load rbenv
  status --is-interactive; and rbenv init - | source
end

# check if nodenv is installed
if [ -d "$HOME/.nodenv" ]
  # create NODENV_ROOT
  set -x NODENV_ROOT "$HOME/.nodenv"
  # add NODENV_ROOT binaries to PATH
  if not contains "$NODENV_ROOT/bin" $PATH
    set -x PATH "$NODENV_ROOT/bin" $PATH
  end
  # load nodenv
  status --is-interactive; and nodenv init - | source
end

# check if gradle is installed
set --local gradle_version '5.6.2'
set --local gradle_bin_path "/opt/gradle/gradle-$gradle_version/bin"
if [ -d $gradle_bin_path ]; and not contains $gradle_bin_path $PATH
  # add gradle to PATH
  set -x PATH $gradle_bin_path $PATH
end
set --erase gradle_version
set --erase gradle_bin_path

# check if yarn (node package manager) is installed
if [ -d "$HOME/.yarn" ]
  # add yarn binaries to PATH
  if not contains "$HOME/.yarn/bin" $PATH
    set -x PATH "$HOME/.yarn/bin" $PATH
  end
  # check if node modules binaries dir exists
  if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ]
    # add node modules binaries to PATH
    if not contains "$HOME/.config/yarn/global/node_modules/.bin" $PATH
      set -x PATH "$HOME/.config/yarn/global/node_modules/.bin" $PATH
    end
  end
end

# add user's private bin to PATH, if it exists
if [ -d "$HOME/bin" ]; and not contains "$HOME/bin" $PATH
  set -x PATH "$HOME/bin" $PATH
end

# remove duplicate entries from path
deduplicate_path

# add default settings for fzf, if it is installed
if command -v fzf > /dev/null ^ /dev/null
  set -x FZF_DEFAULT_OPTS (string join ' ' --\
                                       '--ansi'\
                                       '--inline-info'\
                                       '--tabstop=2'\
                                       (string join ',' --\
                                                    '--color=light'\
                                                    'fg:#666666'\
                                                    'bg:#fafafa'\
                                                    'hl:#f44336'\
                                                    'fg+:#666666'\
                                                    'bg+:#cceae7'\
                                                    'hl+:#f44336'\
                                                    'info:#82a550'\
                                                    'border:#cceae7'\
                                                    'prompt:#39adb5'\
                                                    'pointer:#f44336'\
                                                    'marker:#e57373'))
  if command -v rg > /dev/null ^ /dev/null
    set -x FZF_DEFAULT_COMMAND 'rg --files --hidden'
  else if command -v ag > /dev/null ^ /dev/null
    set -x FZF_DEFAULT_COMMAND 'ag --files-with-matches --hidden'
  else
    set -x FZF_DEFAULT_COMMAND 'find -type -f'
  end
end

# grep default colors
set -x GREP_COLORS (string join ':'\
                                'sl='\
                                'cx='\
                                'ms=1;48;2;255;152;0'\
                                'mc=48;2;255;235;59'\
                                'fn=38;2;236;239;241;48;2;69;90;100'\
                                'ln=38;2;96;125;139;48;2;144;164;174'\
                                'bn=38;2;96;125;139;48;2;144;164;174'\
                                'se=38;2;96;125;139;48;2;144;164;174')

# editor used by `bundle open <gem>`
set -x BUNDLER_EDITOR 'nvim'
# editor used as "line editor"
set -x EDITOR 'nvim'
# editor tried before EDITOR as "visual editor"
set -x VISUAL 'nvim'
# editor for systemd
set -x SYSTEMD_EDITOR 'nvim'

# help GPG to ask for a passphrase when using it for git commits
set -x GPG_TTY (tty)
