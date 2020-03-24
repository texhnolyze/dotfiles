### Helper functions for gradle/w usage and aliases for simplified access

function gradle_run() {
	if [[ -f gradlew ]]; then
		./gradlew $@
	else
		if [[ -f build.gradle ]];
      then gradle $@
		else
      read "answer?There is no build.gradle in this dir. Continue? (y/n) "
      case "$answer" in
        [Yy] ) gradle $@ ;;
        * ) echo 'Aborting!' ;;
      esac
		fi
  fi
}

# gradle aliases
alias g='gradle_run'

# set completion for alias function
compdef gradle_run='gradle'
