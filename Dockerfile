FROM centos:7.4.1708
ADD Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum makecache && yum -y install  wget git  make automake libtool pkgconfig libaio-devel  mariadb-devel java ant  ncurses-compat-libs jq  libaio-devel fio
RUN wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar
RUN tar xvf mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar
RUN rpm -ivh mysql-community-common-5.7.22-1.el7.x86_64.rpm --force --nodeps
RUN rpm -ivh mysql-community-libs-5.7.22-1.el7.x86_64.rpm --force --nodeps &&\
 rpm -ivh mysql-community-client-5.7.22-1.el7.x86_64.rpm --force --nodeps &&\
 rm -rf *.rpm &&\
 rm -rf *.tar
RUN git clone https://github.com/pingcap/benchmarksql.git &&\
 cd benchmarksql &&\
 git checkout 5.0-mysql-support-opt-2.1 &&\
 ant
RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.rpm.sh | bash
RUN yum -y install sysbench
RUN cd ~ &&\
 wget https://download.pingcap.org/tidb-v5.4.0-linux-amd64.tar.gz && cd ~ && tar zxvf tidb-v5.4.0-linux-amd64.tar.gz  && rm -rf tidb-v5.4.0-linux-amd64.tar.gz
RUN cd ~ &&\
 wget https://download.pingcap.org/tidb-toolkit-v5.4.0-linux-amd64.tar.gz && cd ~ && tar zxvf tidb-toolkit-v5.4.0-linux-amd64.tar.gz && rm -rf tidb-toolkit-v5.4.0-linux-amd64.tar.gz

CMD ["/bin/ping", "127.0.0.1"]
