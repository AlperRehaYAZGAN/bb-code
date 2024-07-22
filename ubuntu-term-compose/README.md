### ubuntu-term-compose

Everything is same with base ubuntu-term image. But in addition, it has apt docker installed and dockerd systemctl enabled.

### Build and Run

```bash
# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-ubuntu:22.04-term-compose-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-ubuntu:22.04-term-compose-v1.0.0 .

# run
docker run --privileged -it --rm -p 40020:40020 --name=bb-ubuntu22.04-term-compose-1.0.0 alperreha/bb-ubuntu:22.04-term-compose-v1.0.0
```


### Changelog

- [x] 1.0.0: Main ubuntu image used to biuld get.docker.io shell script. Just docker and compsoe installed. dockerd enabled.

