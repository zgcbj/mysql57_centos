FROM centos

RUN yum -y install  wget git  make automake libtool pkgconfig libaio-devel  mariadb-devel java ant  ncurses-compat-libs jq 
RUN wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar  &&\
 tar xvf mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar &&\
 rpm -ivh mysql-community-common-5.7.22-1.el7.x86_64.rpm &&\
 rpm -ivh mysql-community-libs-5.7.22-1.el7.x86_64.rpm &&\
 rpm -ivh mysql-community-client-5.7.22-1.el7.x86_64.rpm &&\
 rm -rf *.rpm &&\
 rm -rf *.tar 
RUN git clone https://github.com/pingcap/benchmarksql.git &&\
 cd benchmarksql &&\
 git checkout 5.0-mysql-support-opt-2.1 &&\
 ant 
RUN cd ~ &&\
 git clone https://github.com/akopytov/sysbench.git 
RUN cd ~/sysbench &&\
 git checkout 1.0.14 &&\
 ./autogen.sh &&\
 ./configure &&\
 make -j &&\
 make install 
RUN cd ~ &&\
 wget https://download.pingcap.org/tidb-v4.0.3-linux-amd64.tar.gz 
RUN cd ~ &&\ tar zxvf tidb-v4.0.3-linux-amd64.tar.gz 
