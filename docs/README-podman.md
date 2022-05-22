

# https://dev.to/thangchung/start-podman-on-wsl2-in-4-steps-3jn9

# https://opensource.com/article/21/10/podman-windows-wsl

# https://github.com/containers

podman machine init         // fedorA?
podman machine start

https://docs.podman.io/en/latest/markdown/podman-volume.1.html


Error: podman-machine-default: VM does not exist

podman info
 
wsl podman images
wsl podman run -it docker.io/library/busybox



Installing and using the buildah and skopeo commands is exactly the same process.

# skopeo


skopeo is a command line utility that performs various operations on container images and image repositories.

skopeo does not require the user to be running as root to do most of its operations.

skopeo does not require a daemon to be running to perform its operations.

skopeo can work with OCI images as well as the original Docker v2 images.

skopeo inspect docker://registry.fedoraproject.org/fedora:latest

