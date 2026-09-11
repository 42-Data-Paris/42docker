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

ARG USER

RUN useradd -ms /bin/sh $USER
RUN mkdir -p /home/$USER/data

USER $USER
ENV HOME=/home/$USER
ENV HISTFILE=$HOME/data/.bash_history
WORKDIR $HOME/data

RUN echo 'PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> /home/$USER/.bashrc

RUN git clone https://github.com/42-Data-Paris/Nvim-config.git ~/.config/nvim/
RUN nvim --headless "+Lazy! sync" +qa

CMD ["bash"]
