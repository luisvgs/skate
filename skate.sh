#!/bin/sh

INSIDE_REPO=$(git rev-parse --is-inside-work-tree 2>/dev/null)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_PATH=$(pwd)

if [ "$INSIDE_REPO" ]; then
	gum style \
		--foreground 212 --border-foreground 212 --align center "That's it."
	echo "Reflect changes to:"
	WORKTREES=$(git worktree list | awk '{print $1}' | gum choose --no-limit)
	gum confirm "Sure to proceed?" && (cd "$WORKTREES" && git merge "$CURRENT_BRANCH" && cd "$CURRENT_PATH") || echo "Nothing was done."

else
	echo "not in git repo"
fi
