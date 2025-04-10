# Debian XCEnv

A Debian-based Cross-Compile Environment running in Docker.

**Workflows :**

![GitHub Workflow Status](https://github.com/fred-corp/debian-xcenv/actions/workflows/ghcr.yml/badge.svg)

## Summary

* [Summary](#summary)
* [Create a container](#create-a-container)
* [Install linux tools](#install-linux-tools)
  * [Raspberry Pi](#raspberry-pi)
    * [Beaglebone Black](#beaglebone-black)
      * [If your host is an x86_64/amd64 machine](#if-your-host-is-an-x86_64amd64-machine)
      * [If your host is an arm64/aarch64 machine](#if-your-host-is-an-arm64aarch64-machine)
      * [Verify the installation](#verify-the-installation)
* [Building the image from scratch](#building-the-image-from-scratch)
* [License & Acknowledgements](#license--acknowledgements)

## Create a container

Pull image on your system :

```zsh
docker pull ghcr.io/fred-corp/debian-xcenv
```

Run the image :

```zsh
docker run -d --name debian-xcenv-depl -v ./exercises:/root/exercises --network=host --tty=true ghcr.io/fred-corp/debian-xcenv
```

> Note : You can also specify the architecture of the container by adding `:arm64` or `:amd64` to the image name.  
> Note : This commands will mount the `exercises` folder in the current directory to `/root/exercises` in the container. You can change this path to your needs.

Open a shell in the container:

```zsh
docker exec -it -e "TERM=xterm-256color" debian-xcenv-depl /bin/zsh 
```

## Install linux tools

Depending on your target, you'll need different linux tools.

### Raspberry Pi

If you're building for Raspberry Pi, you'll need to install the following tools and files :

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

### Beaglebone Black

If you're building for Beaglebone Black, you'll need to install the following tools and files :

> From the amazing guide from [Quentin Delhaye](https://github.com/parastuffs/linux-kernel-modules/wiki)

#### If your host is an x86_64/amd64 machine

```zsh
wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz
```

```zsh
mkdir -p /opt/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf
```

```zsh
chown $LOGNAME:$LOGNAME /opt/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf
```

```zsh
tar -xf arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz -C /opt/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf
```

```zsh
echo "PATH=/opt/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-linux-gnueabihf/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-linux-gnueabihf/bin/:$PATH" >> ~/.zshrc
```

```zsh
source ~/.zshrc
```

#### If your host is an arm64/aarch64 machine

```zsh
wget https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf.tar.xz
```

```zsh
mkdir -p /opt/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf
```

```zsh
chown $LOGNAME:$LOGNAME /opt/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf
```

```zsh
tar -xf arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf.tar.xz -C /opt/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf
```

```zsh
echo "PATH=/opt/arm-gnu-toolchain-13.2.rel1-aarch64-arm-none-linux-gnueabihf/arm-gnu-toolchain-13.2.Rel1-aarch64-arm-none-linux-gnueabihf/bin/:$PATH" >> ~/.zshrc
```

```zsh
source ~/.zshrc
```

#### Verify the installation

```zsh
arm-none-linux-gnueabihf-gcc -v
```

You can then follow the rest of [Quentin Delhaye's guide](https://github.com/parastuffs/linux-kernel-modules/wiki/Cross-compilation-toolchain#compile-the-kernel-locally) to build the kernel.

```zsh
make -j$(nproc --all) CROSS_COMPILE=arm-none-linux-gnueabihf- ARCH=arm
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
