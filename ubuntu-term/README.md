### ubuntu-term

This is the ubuntu-term image. It is based on the ubuntu:22.04 image and has the ttyd installed. It is used to run the terminal in the browser.

### Build and Run

```bash
# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-ubuntu:22.04-term-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-ubuntu:22.04-term-v1.0.0 .

# run
docker run --privileged -it --rm -p 40020:40020 --name=bb-ubuntu22.04-term-1.0.0 alperreha/bb-ubuntu:22.04-term-v1.0.0
```


### Changelog

- [x] 1.0.0: ttyd, websocat, tmux, screen, asciinema, neovim installed and boilerplate ready.
  This release supports "systemctl" commands due to container starts with "/sbin/init".
  
