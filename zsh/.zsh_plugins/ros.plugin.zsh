### Autosourcing and aliases for ros2 usage. Mostly used
### in rosdocked docker container rosdocked_rolling

# ros aliases
alias cdc='cd $COLCON_WS'

alias rr='ros2 run'
alias rl='ros2 launch'

alias rte='ros2 topic echo'
alias rtl='ros2 topic list'
alias rth='ros2 topic hz'
alias rtp='ros2 topic pub'

alias rpl='ros2 param list'
alias rpg='ros2 param get'

alias cba='cdc; colcon build --symlink-install --continue-on-error'
alias cbn='cdc; colcon build --symlink-install --continue-on-error --packages-select'
alias cb='cdc; colcon build --symlink-install --continue-on-error --packages-up-to'
alias cc='cdc; colcon clean packages --packages-select'
alias cca='cdc; colcon clean packages'

alias sr='source /opt/ros/rolling/setup.zsh'
alias sd='source $COLCON_WS/install/setup.zsh'
alias sa='sr && sd'

# source ros setup
if [[ -f /opt/ros/rolling/setup.zsh ]]; then
  source /opt/ros/rolling/setup.zsh
fi

# source built sources
if [[ -f $COLCON_WS/install/setup.zsh ]]; then
  source $COLCON_WS/install/setup.zsh
fi

# enable autocompletion for ros2 and colcon
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"
