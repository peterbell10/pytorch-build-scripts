#!/bin/bash
PKGS=(pytorch data vision text audio benchmark)

cd ~/git
for pkg in ${PKGS[@]}; do
  if [ ! -d $pkg ]; then
    echo "Directory $pkg does not exist. Please run torch-clone.py first!"
    exit 1
  fi
done

for pkg in ${PKGS[@]}; do
  cd ${pkg}
  git fetch origin
  git checkout main
  git rebase origin/main
  git submodule update --init --recursive --jobs 0
  git prune
  cd ..
done
