#!/bin/bash
PKGS=(pytorch data vision text audio benchmark)

mkdir -p ~/git
cd ~/git
for pkg in ${PKGS[@]}; do
	git clone git@github.com:pytorch/${pkg}.git
done
