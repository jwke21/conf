#!/bin/bash

SESSION="workspace"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESSION

	tmux set-option -t $SESSION status on
	tmux set-option -t $SESSION status-style fg=white,bg=black
	tmux set-option -t $SESSION status-left "#[fg=green]Session: #S "
	tmux set-option -t $SESSION status-left-length 40
	tmux set-otpion -t $SESSION status-right "#[fg=cyan]%d %b %R"
fi

tmux attach-session -t $SESSION
