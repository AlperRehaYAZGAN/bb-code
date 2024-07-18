#### Commands

docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-code:ubuntu22.04-term-ide-0.0.1 .

docker run --runtime=sysbox-runc -it --rm -P -p 3030:3030 -p 40020:40020 --name=alpine-theia alperreha/bb-code:alpine3.19-term-ide-0.0.1
docker run -it --rm -p 3030:3030 -p 40020:40020 --name=ubuntu-code -d alperreha/bb-code:ubuntu22.04-term-ide-0.0.1


### Version Upgrades

- [x] 2.0.0: Websocat SSL error fix by adding package "apk add libressl-dev".
- [x] 1.1.9: Websocat and TTYd "apk add" added.
- [x] 1.1.4: Extensions and sidebar menus added.
- [x] 1.1.5: Webview err fix.