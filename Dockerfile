FROM centos

RUN yum install -y wget
RUN wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar  
RUN tar xvf mysql-5.7.22-1.el7.x86_64.rpm-bundle.tar && yum install -y ncurses-compat-libs  &&\
 rpm -ivh mysql-community-common-5.7.22-1.el7.x86_64.rpm &&\
rpm -ivh mysql-community-libs-5.7.22-1.el7.x86_64.rpm &&\
rpm -ivh mysql-community-client-5.7.22-1.el7.x86_64.rpm &&\
