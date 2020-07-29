# Jenkins

## Important

As of January 17th, 2019 this repository will only update the ARM32v6 images.
For the amd64 images please go to the official Docker repository available
[here](https://hub.docker.com/r/jenkins/jenkins).

----

## Run Jenkins on port 8080

    docker run -d -i -p 8080:8080 -v $PWD:/mnt manorrock/jenkins:arm

----

Note the default work directory of this container is /mnt

----

Please file issues/questions at https://github.com/manorrock/jenkins/issues
