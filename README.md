# Base project to develop with python and docker

## Commands:

```bash
docker-compose up -d
```

```bash
docker cp ~/.ssh/id_rsa python_app:/home/python/.ssh/id_rsa
```

```bash
docker cp ~/.gitconfig python_app:/home/python/.gitconfig
```

```bash
sudo chmod +x .docker/entrypoint.sh
```

```bash
sudo chown -R $USER:$USER .dbdata/
sudo chmod -R 755 .dbdata
```
