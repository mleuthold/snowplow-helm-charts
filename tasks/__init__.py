from invoke import task


@task
def start_local_environment(c):
    c.run("./shell/create-kubernetes-cluster.sh")


@task
def stop_local_environment(c):
    c.run("./shell/delete-kubernetes-cluster.sh")


@task
def install_tillerless(c):
    c.run("./shell/install-tillerless.sh")


@task(pre=[install_tillerless])
def deploy(c):
    c.run(
        """helm tiller run "default" -- helm upgrade --install --wait --timeout 600 --namespace "default" "collector" ./charts/snowplow-scala-stream-collector-kafka""")
