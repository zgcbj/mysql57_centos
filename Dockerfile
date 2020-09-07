FROM centos

RUN yum install -y wget git &&\
 wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar  &&\
 tar xvf mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar && yum install -y ncurses-compat-libs  &&\
 rpm -ivh mysql-community-common-5.7.22-1.el7.x86_64.rpm &&\
 rpm -ivh mysql-community-libs-5.7.22-1.el7.x86_64.rpm &&\
 rpm -ivh mysql-community-client-5.7.22-1.el7.x86_64.rpm &&\
 rm -rf *.rpm &&\
 rm -rf *.tar &&\
 yum install -y java ant &&\
 git clone https://github.com/pingcap/benchmarksql.git &&\
 cd benchmarksql &&\
 git checkout 5.0-mysql-support-opt-2.1 &&\
 ant &&\
 cd .. &&\
 git clone https://github.com/akopytov/sysbench.git &&\
 cd sysbench &&\
 git checkout 1.0.14 &&\
 yum -y install make automake libtool pkgconfig libaio-devel &&\
 yum -y install mariadb-devel &&\
 ./autogen.sh &&\
 ./configure &&\
 make -j &&\
 make install &&\
 cd .. &&\
 wget https://download.pingcap.org/tidb-v4.0.3-linux-amd64.tar.gz &&\
 tar zxvf tidb-v4.0.3-linux-amd64.tar.gz &&\
 yum install -y jq