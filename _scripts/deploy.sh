#!/usr/bin/env bash
set -eu

remote_name="origin"
main_branch="master"
target_branch="gh-pages"
build_dir="_output"

make -B _clean _build
git add "$build_dir"

git commit -m "Updated GitHub Pages"
if [ $? -ne 0 ]; then
    echo "Nothing to commit"
    exit 0
fi

subtree_head=$(git subtree split --prefix "$build_dir" "$main_branch")
if [ -z "$subtree_head"]
then
    echo "Failed to get subtree head"
    exit 1
fi

git push "$remote_name" "$subtree_head":"$target_branch" --force-with-lease
