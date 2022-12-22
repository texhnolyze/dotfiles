export EDITOR="nvim"
export VAGRANT_DETECTED_OS="$(uname)"
export SSH_ASKPASS=ssh-askpass
export GOPATH="$HOME/coding/go"

export COLCON_WS="$HOME/colcon_ws"
export ROS_WORKSPACE="$COLCON_WS"
export COLCON_LOG_LEVEL=30
export RCUTILS_COLORIZED_OUTPUT=1
export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"
export PYTHONWARNINGS=ignore:::setuptools.command.install,ignore:::setuptools.command.easy_install,ignore:::pkg_resources

# export ROS_IP="192.168.1.10"
# export ROS_DOMAIN_ID="66"
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

typeset -U path
path+=(
  $HOME/bin
  $HOME/.local/bin
  $(ruby -e 'print Gem.user_dir')/bin
  $GOPATH/bin
  $HOME/.cargo/bin
  $HOME/.fnm
  ${KREW_ROOT:-$HOME/.krew}/bin
)
