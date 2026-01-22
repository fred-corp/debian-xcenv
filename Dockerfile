# Use latest debian image
FROM debian:latest

# Set the working directory
WORKDIR /root/.

# Copy files to workdir
COPY /src/* .

# Install dependencies
RUN apt update && \
    apt upgrade -y && \
    apt install -y apt-utils && \
    apt install -y curl && \
    apt install -y git && \
    apt install -y zsh
RUN xargs -a packages_list.txt apt install -y
RUN apt install git bc bison flex libssl-dev make libc6-dev libncurses5-dev crossbuild-essential-armhf crossbuild-essential-arm64 -y

# Clean up
RUN apt clean && \
    rm -rf /var/lib/apt/lists/*

# Change hostname
RUN echo "debian-xcenv" > /etc/hostname 

# Change default shell to zsh
RUN chsh -s /bin/zsh

# Install oh-my-zsh
RUN apt install wget -y
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Add contents of zsh_commands.txt at the end of .zshrc
RUN echo "\n# Custom commands\n" >> /root/.zshrc && \
    cat zsh_commands.txt >> /root/.zshrc

# Set the default command to run when starting the container
CMD ["zsh"]