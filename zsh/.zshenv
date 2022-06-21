export EDITOR="nvim"
export VAGRANT_DETECTED_OS="$(uname)"
export SSH_ASKPASS=ssh-askpass
export GOPATH="$HOME/coding/go"

export ROS_WORKSPACE="$HOME/ros2-ws"
export COLCON_LOG_LEVEL=30
export RCUTILS_COLORIZED_OUTPUT=1
export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"
export ROS_IP="192.168.1.100"

typeset -U path
path+=(
  $HOME/bin
  $HOME/.local/bin
  $(ruby -e 'print Gem.user_dir')/bin
  $GOPATH/bin
  $HOME/.cargo/bin
  $HOME/.fnm
  $HOME/.yarn/bin
  ./node_modules/.bin
  ${KREW_ROOT:-$HOME/.krew}/bin
)
