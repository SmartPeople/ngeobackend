FROM elixir:1.4

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && apt-get install -y inotify-tools vim htop git-core nodejs build-essential

ADD . /opt/ngeobackend

WORKDIR /opt/ngeobackend

RUN cd /opt/ngeobackend && mix local.hex --force && mix deps.get && npm install 

CMD bash -c 'sleep infinity'
# CMD bash -c 'mix phoenix.server'