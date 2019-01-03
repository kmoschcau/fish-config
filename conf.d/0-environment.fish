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

# check if gradle is installed
if [ -d '/opt/gradle' ]; and not contains '/opt/gradle' $PATH
  # add gradle to PATH
  set -x PATH '/opt/gradle/bin' $PATH
end

# add user's private bin to PATH, if it exists
if [ -d "$HOME/bin" ]; and not contains "$HOME/bin" $PATH
  set -x PATH "$HOME/bin" $PATH
end

# remove duplicate entries from path
deduplicate_path

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
