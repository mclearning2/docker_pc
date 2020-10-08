FROM mclearning2/pc:basic

# Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.8.3-Linux-x86_64.sh -O $HOME/miniconda.sh
RUN chmod 0755 $HOME/miniconda.sh
RUN $HOME/miniconda.sh -b -p $HOME/conda
RUN rm $HOME/miniconda.sh
ENV PATH="$HOME/conda/bin:$PATH"

RUN pip install django

CMD ["/bin/zsh"]
