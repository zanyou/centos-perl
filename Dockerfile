FROM centos:centos6

ENV PLENV_ROOT /opt/plenv
ENV PATH $PLENV_ROOT/bin:$PLENV_ROOT/shims:$PATH

RUN yum update -y
RUN yum install -y git make gcc bzip2 patch \
  && git clone git://github.com/tokuhirom/plenv.git $PLENV_ROOT \
  && git clone git://github.com/tokuhirom/Perl-Build.git $PLENV_ROOT/plugins/perl-build \
  && echo 'eval "$(plenv init -)"' >> .bash_profile \
  && exec $SHELL -l

RUN . /etc/profile; MAKEFLAGS="-j 5" plenv install 5.24.1
RUN . /etc/profile; plenv local 5.24.1
RUN . /etc/profile; plenv install-cpanm
RUN . /etc/profile; cpanm install Carton
