FROM mclearning2/pc:basic

RUN pip3 install --upgrade django \
                           libsass \
                           google-api-python-client \
                           google-auth-httplib2 \
                           google-auth-oauthlib \
                           atlassian-python-api \
                           django-allauth

COPY .vimrc /tmp
RUN cat /tmp/.vimrc >> $HOME/.vimrc
RUN echo "alias dj.on=\"echo 'yes' | python3 manage.py collectstatic; python3 manage.py makemigrations; python3 manage.py migrate; python3 manage.py runserver\"" >> $HOME/.zshrc
