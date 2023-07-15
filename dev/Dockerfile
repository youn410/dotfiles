FROM centos:centos7

MAINTAINER dnoura

RUN yum -y update && \
  yum -y install \
  curl \
  git \
  vim \
  wget \
  zsh

RUN cd $HOME && \
  mkdir -p .local/share/zsh/site-functions && \
  mkdir -p .config/git

RUN chsh -s /bin/zsh

WORKDIR /tmp/dotfiles

CMD ["/bin/zsh"]
