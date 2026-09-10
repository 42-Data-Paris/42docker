FROM ubuntu:latest

RUN apt-get update \ 
	&& apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:neovim-ppa/unstable \
	&& apt-get update \
	&& apt-get install -y \
		neovim \
		sqlite3 \
		git \
		build-essential \
		curl \
		nodejs \
		npm \
	&& rm -rf /var/lib/apt/lists/*

RUN npm install -g tree-sitter-cli@latest

RUN mkdir -p /home/$USER/data
ARG USER
RUN useradd -ms /bin/sh $USER

USER $USER
ENV HOME=/home/$USER
WORKDIR $HOME/data

RUN git clone https://github.com/42-Data-Paris/Nvim-config.git ~/.config/nvim/
RUN nvim --headless "+Lazy! sync" +qa

CMD ["bash"]
