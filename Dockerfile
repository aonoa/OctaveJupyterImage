FROM avikdatta/basejupyterdockerimage

MAINTAINER reach4avik@yahoo.com

ENTRYPOINT []

ENV NB_USER vmuser

USER root
WORKDIR /root/

RUN add-apt-repository ppa:octave/stable \
    apt-get update \
    && apt-get install --no-install-recommends -y \
    octave \
    &&  apt-get purge -y --auto-remove  \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*
    
USER $NB_USER
WORKDIR /home/$NB_USER

RUN mkdir -p /home/$NB_USER/tmp

ENV PYENV_ROOT="/home/$NB_USER/.pyenv"   
ENV PATH="$PYENV_ROOT/libexec/:$PATH" 
ENV PATH="$PYENV_ROOT/shims/:$PATH"

RUN eval "$(pyenv init -)" 
RUN pyenv global 3.5.2

RUN pip install octave_kernel

RUN rm -rf /home/$NB_USER/.cache \
    && rm -rf /home/$NB_USER/tmp
    
EXPOSE 8886

CMD ["jupyter","lab","--ip=0.0.0.0","--port=8886","--no-browser"]
