#@IgnoreInspection BashAddShebang
.PHONY: check check.make check.minikube check.kubectl check.helm

check: \
	check.make \
	check.minikube \
	check.kubectl \
	check.helm

check.make:
	type make
	make --version | grep "GNU Make 4.2.1"

check.minikube:
	if [[ "$(ENV)" == 'local' ]]; then \
		type minikube; \
		MY_MINIKUBE_VERSION=($$(minikube version)); echo $${MY_MINIKUBE_VERSION[2]}; \
		if [[ "$${MY_MINIKUBE_VERSION[2]}" < "v0.33.1" ]]; then echo "please update your Minikube version"; exit 1; fi; \
		if (( $$(minikube config get cpus) < 2)); then echo "configure more cpus for minikube: minikube config set cpus 2"; exit 1; fi; \
		if (( $$(minikube config get memory) < 8192)); then echo "configure more memory for minikube: minikube config set memory 8192"; exit 1; fi; \
	fi

check.kubectl:
	type kubectl

check.helm:
	type helm
	helm plugin list | grep "^tiller[[:space:]]"
