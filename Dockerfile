from ubuntu:focal

ARG USER_ID="kmc"
ARG USER_PWD="kmc"
ENV HOME /home/${USER_ID}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN apt-get update && apt-get install -y zsh curl git vim sudo build-essential wget python python3

# Add User
RUN groupadd -g 1000 ${USER_ID}
RUN useradd -rm -d /home/${USER_ID} -s /bin/zsh -g root -G ${USER_ID} -u 1000 ${USER_ID}
RUN echo "${USER_ID}:${USER_PWD}" | chpasswd
RUN echo "${USER_ID} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN usermod -aG sudo ${USER_ID}

RUN touch $HOME/.zshrc

# Oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel 10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
RUN echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> $HOME/.zshrc
RUN echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> $HOME/.zshrc
RUN echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> $HOME/.zshrc
COPY .p10k.zsh $HOME

# ZSH Plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone git://github.com/wting/autojump.git && cd autojump && SHELL="zsh" ./install.py
RUN git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/k
RUN echo "[[ -s /home/kmc/.autojump/etc/profile.d/autojump.sh ]] && source /home/kmc/.autojump/etc/profile.d/autojump.sh" >> $HOME/.zshrc
RUN echo "autoload -U compinit && compinit -u" >> $HOME/.zshrc
RUN echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

RUN sed -i 's/plugins=(git)/plugins=(git vi-mode zsh-autosuggestions k)/g' $HOME/.zshrc

# FZF
# 여기 이후에는 이상하게 zsh가 써지지 않는다.
RUN git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
RUN $HOME/.fzf/install

USER $USER_ID
WORKDIR $HOME

CMD ["/bin/zsh"]
