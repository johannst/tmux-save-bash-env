#!/usr/bin/env bash
# tmux-save-bash-env -- scripts/save.sh
# author: johannst

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/common.sh

export OUTPUT_DIR="$(tmux show-env -g TMUX_PLUGIN_MANAGER_PATH | cut -d= -f2)/../saved-bash-env"
[[ ! -d $OUTPUT_DIR ]] && mkdir $OUTPUT_DIR

function genCmdStr() {
	local s=$1
	local w=$2
	local p=$3
	backup_file=$OUTPUT_DIR/bash_env_$s.$w.$p
	:> $backup_file
	cmd=""
	cmd+="set +o >> $backup_file;"
	cmd+="export -p >> $backup_file;"
	echo "$cmd"
}
runCommandInAllPanes

