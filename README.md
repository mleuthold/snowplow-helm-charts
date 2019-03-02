# snowplow-helm-charts

# install build tool
and other libraries, e.g. docker
```bash
pip3 install --user invoke docker
```
list all build tasks
```bash
inv --list
```

# setup local Kubernetes
create local Kubernetes cluster
```bash
inv start_local_environment
```
delete local Kubernetes cluster
```bash
inv stop_local_environment
```
