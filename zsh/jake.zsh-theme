# jake.zshrc-theme
ZSH_THEME_GIT_PROMPT_PREFIX="${FG[130]}(${FG[006]}"
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[220]}*${FG[130]})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="${FG[130]})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# dashed separator size
function dashes {
	echo $COLUMNS
}

# primary prompt: dashed separator, directory and vcs info
PS1="${FG[237]}\${(l.\$(dashes)..-.)}%{$reset_color%}
${FG[130]}%1~%{$reset_color%} \$(git_prompt_info)${FG[006]}»%{$reset_color%} "
PS2="%{$fg[red]%}\ %{$reset_color%}"


# right prompt: return code:, and user@host
RPS1=" ${FG[237]}%n@%m%{$reset_color%}"
