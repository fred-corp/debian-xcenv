# Debian XCEnv

A Debian-based Cross-Compile environment running in Docker.

**Workflows :**

![GitHub Workflow Status](https://github.com/fred-corp/debian-xcenv/actions/workflows/ghcr.yml/badge.svg)

## Create container

Pull image on your system (replace `<architecture>` with your target architecture (amd64 or arm64)):

```zsh
docker pull ghcr.io/fred-corp/debian-xcenv:latest-<architecture>
```

Run the image (replace `<architecture>` with your target architecture (amd64 or arm64)):

```zsh
docker run -d --name debian-xcenv-depl -v ./exercises:/root/exercises --network=host --tty=true ghcr.io/fred-corp/debian-xcenv:latest-<architecture>
```

> Note : This commands will mount the `exercises` folder in the current directory to `/root/exercises` in the container. You can change this path to your needs.

Open a shell in the container:

```zsh
docker exec -it -e "TERM=xterm-256color" debian-xcenv-depl /bin/zsh 
```

## Install linux tools

Depending on your target, you'll need different linux tools.  
For example, building for Raspberry Pi, you'll need to install the following tools :

> From the amazing guide from [Jeff Geerling](https://www.jeffgeerling.com/blog/2020/cross-compiling-raspberry-pi-os-linux-kernel-on-macos)

```zsh
git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
KERNEL=kernel8
```

Create the `.config` file for the kernel:

```zsh
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
```

Then, you can build the kernel:

```zsh
make -j$(nproc --all) ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs
```

## Building the image from scratch

If you want to build the image from scratch, you can do so by running the following command in the root of the repository:

```zsh
docker-compose build
```

Then, you can run the image using the following command:

```zsh
docker-compose up -d
```

## License & Acknowledgements

Made with ❤️, lots of ☕️, and lack of 🛌

[![License: GPL v3](https://www.gnu.org/graphics/gplv3-127x51.png)](https://www.gnu.org/licenses/gpl-3.0.en.html)  
[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
