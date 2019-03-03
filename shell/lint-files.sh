#!/usr/bin/env bash

set -xe

# check all YAML files, except helm charts, because ...
yamllint -d "{extends: relaxed,  ignore: \"charts/**/*\"}" .

# helm has it's own linter
helm lint charts/*

# check all *.sh files
while read -r file
do
	shellcheck --format=gcc "${file}";
done < <(find . -type f -name "*.sh" -not -path "./.git/*" -not -path "./target/*")

# check all files with SHEBANG line
while read -r file
do
	shellcheck --format=gcc --shell=sh "${file}";
done < <(grep -IRl "#\!\(/usr/bin/env \|/bin/\)sh" --exclude-dir "var" --exclude "*.txt" --exclude-dir ".git" --exclude-dir "target")