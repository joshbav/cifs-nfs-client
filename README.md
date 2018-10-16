docker run -it --name cifsserver -p 139:139 -p 445:445 -d dperson/samba \
            -u "example1;badpass" \
            -u "example2;badpass" \
            -s "public;/share;yes;no;yes;all;example1;example1" \
            -s "users;/srv;no;no;no;example1,example2" \
            -s "example1 private;/example1;no;no;no;example1" \
            -s "example2 private;/example2;no;no;no;example2"




FROM joshbav/centos

docker run -it --privileged joshbav/centos bash

RUN yum install cifs-utils -y
RUN mkdir /nfs /cifs

mount -t cifs //192.168.1.20/public /t -o user="example1",pass="badpass",sec=ntlm,vers=2.1


