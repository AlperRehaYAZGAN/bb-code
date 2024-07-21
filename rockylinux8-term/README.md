### rockylinux8-term

This is the rockylinux8 image. It is based on the rockylinux:8 image and has the ttyd installed. It is used to run the terminal in the browser.

### Build and Run

```bash
# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-rockylinux:8-term-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-rockylinux:8-term-v1.0.0 .

# run
docker run --privileged -it --rm -p 40020:40020 --name=bb-rockylinux-8-term-1.0.0 alperreha/bb-rockylinux:8-term-v1.0.0
```


### Changelog

- [x] 1.0.0: ttyd, websocat, tmux, screen, asciinema, neovim installed and boilerplate ready.
  This release supports "systemctl" commands due to container starts with "/sbin/init".
  
