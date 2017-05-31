FROM elixir:1.4

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && apt-get install -y inotify-tools vim htop git-core nodejs build-essential

ADD . /opt/ngeobackend

WORKDIR /opt/ngeobackend

RUN cd /opt/ngeobackend && mix local.hex --force && mix deps.get && mix local.rebar --force && npm install

RUN MIX_ENV=prod mix compile

# CMD bash -c 'sleep infinity'
CMD bash -c 'MIX_ENV=prod HOST="127.0.0.1" mix ecto.migrate && MIX_ENV=prod HOST="127.0.0.1" mix phoenix.server'