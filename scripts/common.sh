# tmux-save-bash-env -- scripts/common.sh
# author: johannst


# This function executes a command in every tmux pane in every session on the host
# The command executed in every pan must be provided by implementing the 'genCmdStr'
# callback function. This callback is called from within 'runCommandInAllPanes' and gets
# passed three arguments which are:
#  $1 - session name
#  $2 - window id
#  $3 - pane id
# The callback can be implemented as following example:
# function genCmdStr() {
#    local s=$1; local w=$2; local p=$3;
#    local cmd="echo 'I am running in session=$s window=$w pane=$p'"
#    echo "$cmd"
# }

function runCommandInAllPanes() {
	for s in $(tmux list-sessions -F '#S'); do
		for w in $(tmux list-windows -F '#I' -t $s); do
			for p in $(tmux list-panes -F '#P' -t $s:$w); do
				echo "Saving bash for $s:$w.$p ..."
				# put forground process into background
				tmux send-keys -t $s:$w.$p C-[
				sleep 0.5
				tmux send-keys -t $s:$w.$p C-z

				# clean cmd line and go into insert mode
				# due to my special vim bash wizardry
				tmux send-keys -t $s:$w.$p i C-e C-u

				if declare -F genCmdStr > /dev/null; then local command=$(genCmdStr $s $w $p); fi
				tmux send-keys -t $s:$w.$p "${command:-:;} [[ \$(jobs -p | wc -l) -gt 0 ]] && fg || :" C-m
			done
		done
	done
}

