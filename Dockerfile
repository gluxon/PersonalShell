# Personal version controlled Linux VM.
FROM ubuntu:16.10
MAINTAINER Brandon Cheng

RUN apt-get update

# Typical Linux utilities
RUN apt-get -y install man sudo software-properties-common build-essential

# Favorites
RUN apt-get -y install fish git

# Neovim
RUN add-apt-repository ppa:neovim-ppa/unstable && \
  apt-get update && \
  apt-get install neovim

# Setup user
RUN useradd -ms /bin/fish gluxon -G sudo
RUN echo 'gluxon ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER gluxon
COPY home /home/gluxon
WORKDIR /home/gluxon
RUN sudo chown -R gluxon:gluxon /home/gluxon

# Configure fish
ENV fish_greeting="Welcome to your personal shell."

# Configure Neovim: Setup pathogen and install vim-fugitive plugin
ADD https://tpo.pe/pathogen.vim .config/nvim/autoload/pathogen.vim
RUN git clone git://github.com/tpope/vim-fugitive.git .config/nvim/bundle/vim-fugitive

# Install radare2
RUN git clone https://github.com/radare/radare2 /tmp/radare2
RUN cd /tmp/radare2 && sys/install.sh

# Start
RUN sudo chown -R gluxon:gluxon /home/gluxon
RUN cd /home/gluxon
ENTRYPOINT ["fish"]
