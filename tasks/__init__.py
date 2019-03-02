from invoke import task


@task
def start_kubernetes(c):
    c.run("./shell/start-kubernetes-cluster.sh")


@task
def stop_kubernetes(c):
    c.run("minikube stop")


@task
def delete_kubernetes(c):
    c.run("minikube delete")


@task
def install_tillerless(c):
    c.run("./shell/install-tillerless.sh")


@task(install_tillerless)
def deploy_collector(c):
    c.run(
        """helm tiller run "default" -- helm upgrade --install --wait --timeout 600 --namespace "default" "collector" ./charts/snowplow-scala-stream-collector-kafka""")


@task(install_tillerless)
def deploy_kafka(c):
    c.run("./shell/install-kafka.sh")


@task(install_tillerless, deploy_kafka, deploy_collector)
def deploy(c):
    print()


@task(default=True)
def lint(c):
    c.run("./shell/lint-files.sh")
