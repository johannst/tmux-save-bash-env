#!/usr/bin/env bash
# tmux-save-bash-env -- save-bash-env.tmux
# author: johannst

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key -T prefix M-s run-shell "$CURRENT_DIR/scripts/save.sh"
tmux bind-key -T prefix M-r run-shell "$CURRENT_DIR/scripts/restore.sh"

