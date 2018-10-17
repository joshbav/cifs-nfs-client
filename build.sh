docker build --squash -t joshbav/cifs-nfs-client:latest .
echo
echo
echo
echo Pushing newly built image to dockerhub
echo
docker push joshbav/cifs-nfs-client:latest
echo
echo
echo Uploading all files to github.com/joshbav/cifs-nfs-client
echo
# All files to automatically be added
git add *
git config user.name “joshbav”
git commit -m "scripted commit $(date +%m-%d-%y-%H-%M-%S)"
git push -u origin master










