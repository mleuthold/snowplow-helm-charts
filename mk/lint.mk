#@IgnoreInspection BashAddShebang
.PHONY: lint lint.yaml lint.shell lint.scripts lint.helm

lint: \
	lint.yaml \
	lint.shell \
	lint.scripts \
	lint.helm

lint.yaml:
	# check all YAML files
	docker run --rm -v $$(pwd):/workdir giantswarm/yamllint -d "{extends: relaxed, ignore: \"*charts/**/*\", "rules": {"line-length": {"max": 120}}}" .

lint.shell:
	# check all *.sh files
	for file in $$(find . -type f -name "*.sh" -not -path "./.git/*"); do \
		docker run --rm -v $$(pwd):/mnt koalaman/shellcheck:stable --format=gcc $$file; \
	done;

lint.scripts:
	# check all files with SHEBANG line
	for file in $$(grep -IRl "#\!\(/usr/bin/env \|/bin/\)sh" --exclude-dir "var" --exclude "*.txt" --exclude-dir ".git"); do \
		docker run --rm -v $$(pwd):/mnt koalaman/shellcheck:stable --format=gcc --shell=sh $$file; \
	done;

lint.helm:
	# check all helm charts
	helm lint *charts/*
