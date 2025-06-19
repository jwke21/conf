#!/bin/bash

SESSION="workspace"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESSION
fi

tmux attach-session -t $SESSION
