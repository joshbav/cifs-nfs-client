#### Beginning of CIFS test

# First we will start a samba server

docker run -it --name cifsserver -p 139:139 -p 445:445 -d dperson/samba \
            -u "user1;password" \
            -s "public;/share;yes;no;yes;all;user1;user1" 

docker ps

# Now we will start a CIFS client container, the Dockerfile is in this repo
# We're using host networking so we can use 127.0.0.1 to get to the CIFS server,
# in production you wouldn't necessarily need to do this
# To do the CIFS mount SYS_ADMIN and DAC_READ_SEARCH are necessary permissions

docker run -it --network host --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH joshbav/cifs-nfs-client bash

mount -t cifs //127.0.0.1/public /cifs -o user="user1",pass="password",sec=ntlm,vers=2.1

# See if it's mounted
mount |grep cifs

# Is there anything in /cifs? No
ls /cifs

# Let's create a file
touch /cifs/new
ls /cifs

# Let's write to it
echo update >/cifs/new

# Let's read from it
cat /cifs/new

# exit container
exit

docker kill cifsserver
docker rm cifsserver

#### End of CIFS client test



####### Beginning of NFS client test

# First we will start an NFS server

docker run -d --name nfsserver --privileged -v /tmp:/nfsshare -e SHARED_DIRECTORY=/nfsshare -p 2049:2049 itsthenetwork/nfs-server-alpine:latest

docker ps

docker run -it --network host --cap-add SYS_ADMIN joshbav/cifs-nfs-client bash


