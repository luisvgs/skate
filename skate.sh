#!/bin/sh

INSIDE_REPO=$(git rev-parse --is-inside-work-tree 2>/dev/null)

if [ "$INSIDE_REPO" ]; then
	echo "Reflex changes too:"
	WORKTREES=$(git worktree list | awk '{print $1}' | gum choose --no-limit)
	gum confirm && (cd $WORKTREES) || echo "Nothing was done."

else
	echo "not in git repo"
fi
