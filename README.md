## Beginning of CIFS test

First we will start a samba server

`docker run -it --name cifsserver -p 139:139 -p 445:445 -d dperson/samba \
            -u "user1;password" \
            -s "public;/share;yes;no;yes;all;user1;user1" 
`

`docker ps`

Now we will start a CIFS client container.
The Dockerfile is in this repo and it's nothing special.
We're using host networking so we can use 127.0.0.1 to get to the CIFS server,
in production you wouldn't necessarily need to do this.
To do the CIFS mount SYS_ADMIN and DAC_READ_SEARCH are necessary permissions.

`docker run -it --network host --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH joshbav/cifs-nfs-client bash`

Now we are inside the container

Note all this can be automated with environment variables and a startup script

`mount -t cifs //127.0.0.1/public /cifs -o user="user1",pass="password",sec=ntlm,vers=2.1`

See if it's mounted

`mount |grep cifs`

Is there anything in /cifs? No

`ls /cifs`

Let's create a file

`touch /cifs/new`

`ls /cifs`

Let's write to it

`echo update >/cifs/new`

Let's read from it

`cat /cifs/new`

Let's delete it

`rm /cifs/new`

Exit container

`exit`


`docker stop cifsserver`

`docker rm cifsserver`

End of CIFS client test



