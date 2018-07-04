# personal file for fish environment variables

# define variables for the XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"

# add user's .local/bin to path for compatibility with systemd
if [ -d "$HOME/.local/bin" ]
  set -x PATH "$HOME/.local/bin" $PATH
end

# check if openJDK 8 is installed
if [ -d '/usr/lib/jvm/java-8-openjdk-amd64' ]
  # create JAVA_HOME
  set -x JAVA_HOME '/usr/lib/jvm/java-8-openjdk-amd64'
  # add JAVA_HOME binary directory to PATH
  set -x PATH "$JAVA_HOME/bin" $PATH
end

# check if Scala is installed
if [ -d '/usr/local/share/scala' ]
  # create SCALA_HOME
  set -x SCALA_HOME '/usr/local/share/scala'
  # add SCALA_HOME binary directory to PATH
  set -x PATH "$SCALA_HOME/bin" $PATH
end

# check if Eclipse Oxygen is installed
if [ -d "$HOME/eclipse/oxygen/eclipse" ]
  # create ECLIPSE_HOME
  set -x ECLIPSE_HOME "$HOME/eclipse/oxygen/eclipse"
  # check if Eclim plugin is installed
  if [ -d "$ECLIPSE_HOME/plugins/org.eclim_2.7.0" ]
    # add Eclim binary directory to PATH
    set -x PATH "$ECLIPSE_HOME/plugins/org.eclim_2.7.0/bin" $PATH
  end
end

# check if Go(lang) is installed
if [ -d "$HOME/go" ]
  # set the path for Go(lang) sources and things
  set -x GOPATH "$HOME/go"
  # add Go binaries to PATH
  set -x PATH "$GOPATH/bin" $PATH
end

# check if gvm (Go version manager) is installed
if [ -s "$HOME/.gvm/scripts/gvm" ]
  # source gvm
  # . "$HOME/.gvm/scripts/gvm"
end

# check if rustup (Rust version and package manager) is installed
if [ -d "$HOME/.cargo" ]
  # add rustup (Rust version and package manager) to path
  set -x PATH "$HOME/.cargo/bin" $PATH
end

# check if pyenv is installed
if [ -d "$HOME/.pyenv" ]
  # create PYENV_ROOY
  set -x PYENV_ROOT "$HOME/.pyenv"
  # add PYENV_ROOT binaries to PATH
  set -x PATH "$PYENV_ROOT/shims" "$PYENV_ROOT/bin" $PATH
  # enabled dynamic Python libraries
  set -x PYTHON_CONFIGURE_OPTS '--enable-shared'
  # load pyenv
  status --is-interactive; and pyenv init - | source
end

# check if rbenv is installed
if [ -d "$HOME/.rbenv" ]
  # create RBENV_ROOT
  set -x RBENV_ROOT "$HOME/.rbenv"
  # add rbenv to PATH
  set -x PATH "$RBENV_ROOT/shims" "$RBENV_ROOT/bin" $PATH
  # load rbenv
  status --is-interactive; and rbenv init - | source
end

# check if gradle is installed
if [ -d '/opt/gradle' ]
  # add gradle to PATH
  set -x PATH '/opt/gradle/bin' $PATH
end

# add user's private bin to PATH, if it exists
if [ -d "$HOME/bin" ]
  set -x PATH "$HOME/bin" $PATH
end

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
