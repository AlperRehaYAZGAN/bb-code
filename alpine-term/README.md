### alpine-term

This is the alpine-term image. It is based on the alpine image and has the ttyd installed. It is used to run the terminal in the browser.

### Build and Run

```bash
# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-alpine:3.19-term-v1.0.0 .
# build
docker build -t alperreha/bb-alpine:3.19-term-v1.0.0 .

# run
docker run --runtime=sysbox-runc --privileged -it --rm -p 40020:40020 --name=bb-alpine3.19-term-1.0.0 alperreha/bb-alpine:3.19-term-v1.0.0
```


### Changelog

- [x] 1.0.0: ttyd, websocat, tmux, screen, asciinema, neovim installed and boilerplate ready.
  This release is openrc included and supports "service" commands.
  

