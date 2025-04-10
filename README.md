# Debian XCEnv

A Debian-based Cross-Compile environment running in Docker.

**Workflows :**

![GitHub Workflow Status](https://github.com/fred-corp/debian-xcenv/actions/workflows/ghrc.yml/badge.svg)

## How to use

Pull image on your system (replace `<architecture>` with your target architecture (amd64 or arm64)):

```zsh
docker pull ghcr.io/fred-corp/debian-xcenv:latest-<architecture>
```

Run the image (replace `<architecture>` with your target architecture (amd64 or arm64)):

```zsh
docker run -d --name debian-xcenv-depl -v ./exercices:/root/exercices --network=host --tty=true ghcr.io/fred-corp/debian-xcenv:latest-<architecture>
```

> Note : This commands will mount the `exercices` folder in the current directory to `/root/exercices` in the container. You can change this path to your needs.

Open a shell in the container:

```zsh
docker exec -it -e "TERM=xterm-256color" debian-xcenv-depl /bin/zsh 
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
