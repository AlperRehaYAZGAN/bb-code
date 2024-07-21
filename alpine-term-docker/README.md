### alpine-term-docker

Everything is same with base alpine-term image. But in addition, it has apk docker installed and dockerd supervisor service is added.

### Build and Run

```bash
# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-alpine:3.19-term-docker-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-alpine:3.19-term-docker-v1.0.0 .

# run
docker run --runtime=sysbox-runc --privileged -it --rm -p 40020:40020 --name=bb-alpine3.19-term-docker-1.0.0 alperreha/bb-alpine:3.19-term-docker-v1.0.0 .
```


### Changelog

- [x] 1.0.0: docker installed via apk and supervisord config ini file added into supervisor.d directory.
