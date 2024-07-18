#### Ubuntu 22.04 Terminal


### Build and Run

```bash
# build
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-ubuntu:22.04-term-v0.0.1 .
docker build -t alperreha/bb-ubuntu:22.04-term-v0.0.1 .

# run
docker run --runtime=sysbox-runc -it --rm -p 40020:40020 --name=ubuntu22.04-term-0.0.1 alperreha/bb-ubuntu:22.04-term-v0.0.1
```
### Version Upgrades

- [x] 2.0.0: Websocat SSL error fix by adding package "apk add libressl-dev".
- [x] 1.1.9: Websocat and TTYd "apk add" added.
- [x] 1.1.4: Extensions and sidebar menus added.
- [x] 1.1.5: Webview err fix.