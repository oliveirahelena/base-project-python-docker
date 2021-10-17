# Base project to develop with python and docker

## Commands inside the container:

```bash
pre-commit install -t pre-commit
pre-commit install -t pre-push
```

```bash
chmod +x /.docker/entrypoint.sh
```

## Commands outside the container:

```bash
docker cp ~/.ssh/id_rsa python_app:/home/python/.ssh/id_rsa
```

```bash
docker cp ~/.gitconfig python_app:/home/python/.gitconfig
```

```bash
sudo chmod +x .docker/entrypoint.sh
```
