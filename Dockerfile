FROM ubuntu:latest

RUN apt-get update \ 
&& apt-get install -y software-properties-common \
&& add-apt-repository -y ppa:neovim-ppa/unstable \
&& apt-get install -y neovim sqlite3 git build-essential

ARG USER
RUN useradd -ms /bin/sh $USER
USER $USER
WORKDIR /home/$USER

RUN git clone https://github.com/42-Data-Paris/Nvim-config.git ~/.config/nvim/

CMD ["bash"]
