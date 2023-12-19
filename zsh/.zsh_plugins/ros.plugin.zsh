### Autosourcing and aliases for ros2 usage. Used either
### Ubuntu or in rosdocked docker container rosdocked_iron

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

alias cba='sr; cdc; colcon build --symlink-install --continue-on-error'
alias cbs='sr; cdc; colcon build --symlink-install --continue-on-error --packages-select'
alias cb='sr; cdc; colcon build --symlink-install --continue-on-error --packages-up-to'
alias cc='cdc; colcon clean packages --packages-select'
alias cca='cdc; colcon clean packages'

alias sv='source ~/coding/bit-bots/venv/bin/activate'
alias sr='source /opt/ros/iron/setup.zsh'
alias sd='source $COLCON_WS/install/setup.zsh'
alias sa='sv && sr && sd'

rid() {
  export ROS_DOMAIN_ID="$1"
}

# enable autocompletion for ros2 and colcon
# for this previous loading of bashcompinit is required
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

# source ros setup
# if [[ -f /opt/ros/iron/setup.zsh ]]; then
  # source /opt/ros/iron/setup.zsh
# fi

# # source built sources
# if [[ -f $COLCON_WS/install/setup.zsh ]]; then
  # source $COLCON_WS/install/setup.zsh
# fi
