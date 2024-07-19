FROM redis:latest

# Install packages needed for tuning redis
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  ca-certificates \
  curl \
  procps

RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
