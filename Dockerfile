FROM ubuntu:focal

ARG USER
ARG HOME

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN apt-get update && \
    apt-get install -y zsh \
                       curl \
                       git \ 
                       vim \
                       vim-gtk \
                       ripgrep \
                       fd-find \
                       xclip \
                       sudo \
                       build-essential \
                       wget \
                       net-tools \
                       openssh-server \
                       python \
                       python3 \
                       python3-dev \
                       python3-pip \
                       python3-venv \
                       cmake \
                       npm \
                       inxi screenfetch # MOTD

RUN sudo npm install -g sass

# Oh my zsh
# ==================================================================================================
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY .p10k.zsh $HOME
# ==================================================================================================

# Powerlevel 10k
# ==================================================================================================
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
RUN echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> $HOME/.zshrc
RUN echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> $HOME/.zshrc
RUN echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> $HOME/.zshrc
# ==================================================================================================

# Vim
# ==================================================================================================
COPY .vimrc $HOME
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim 
RUN vim +PluginInstall +qall
RUN echo "colorscheme dracula" >> $HOME/.vimrc

# ---- YCM ---- 
RUN cd $HOME/.vim/bundle/YouCompleteMe && \
    git submodule update --init --recursive && \
    python3 install.py

# ---- Black ----
RUN cd $HOME/.vim/bundle/black && \
    git checkout origin/stable -b stable

# ==================================================================================================

# ZSH Plugins
# ==================================================================================================
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone git://github.com/wting/autojump.git && cd autojump && SHELL="zsh" ./install.py
RUN git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/k
RUN echo "[[ -s /home/kmc/.autojump/etc/profile.d/autojump.sh ]] && source /home/kmc/.autojump/etc/profile.d/autojump.sh" >> $HOME/.zshrc
RUN echo "autoload -U compinit && compinit -u" >> $HOME/.zshrc
RUN echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
RUN sed -i 's/plugins=(git)/plugins=(git vi-mode zsh-autosuggestions k ripgrep )/g' $HOME/.zshrc
# ==================================================================================================

# MOTD (Message of the day)
# ==================================================================================================
COPY motd.sh $HOME
RUN echo "bash $HOME/motd.sh" >> $HOME/.zshrc
RUN sudo chsh -s `which zsh`
# ==================================================================================================

# FZF
# ==================================================================================================
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
RUN $HOME/.fzf/install
RUN echo "export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'" >> $HOME/.zshrc
RUN echo "export FZF_DEFAULT_OPT='fd --type f --hidden --follow --exclude .git'" >> $HOME/.zshrc
# ==================================================================================================

# 한글 사용
ENV LC_ALL=C.UTF-8

# Add User
# ==================================================================================================
RUN groupadd -g 1000 ${USER}
RUN useradd -rm -d /home/${USER} -s /bin/zsh -g root -G ${USER} -u 1000 ${USER}
RUN echo "${USER}:${USER}" | chpasswd
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN usermod -aG sudo ${USER}
RUN chown -R $USER $HOME
# ==================================================================================================

RUN echo "alias ls=\"k\"" >> $HOME/.zshrc

# ssh server
# ===
RUN service ssh start
# ===

USER $USER

ARG WORKSPACE=/workspace

RUN sudo mkdir -p ${WORKSPACE}
RUN sudo chown kmc:kmc ${WORKSPACE}
RUN sudo chmod 755 $WORKSPACE

WORKDIR $WORKSPACE

ENTRYPOINT sudo service ssh restart && zsh
