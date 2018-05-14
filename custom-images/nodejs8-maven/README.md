# Node.js 6 Jenkins slave

Node.js 6 and MAVEN docker image. This work is based on the excellent node.js 4 image that is available in Openshift and in Github (https://github.com/openshift/jenkins/tree/master/slave-nodejs) by Ben.

This image also includes chrome for unit tests.

## Build the image

The image can be built on Openshift with the Docker build strategy. To enable Jenkins to use the image the build must be created in either the project where jenkins is located or made available via an image stream visible for Jenkins. I.e. either tag it to an image stream in the same project as Jenkins or into the global openshift namespace.

First you need to create a build secret to access the source repository (can be skipped if your git repo does not require authentication):

`oc secrets new-basicauth <secret_name> --password=<token>`

Then you create the build:

`oc new-build --name=jenkins-slave-nodejs6 https://github.com/jmetso/openshift.git --context-dir=custom-images/jenkins-nodejs6-slave --strategy=docker --build-secret=<secret name> --labels='role=jenkins-slave,app=jenkins'`

If the build does not trigger automatically or you want to rebuild the image, you can trigger the build again with:

`oc start-build jenkins-slave-nodejs6`

Monitor that the build completes successfully.

To have a shorter image label, annotation _slave-label=<label>_ needs to be added to the resulting image stream. Edit the image stream with

`oc edit is jenkins-slave-nodejs6`

Add the following into _metadata_ section in the imagestream object:

`  annotations:`

`    slave-label: nodejs6`

Make sure that the indentations are correct.

## Jenkins configuration

If you have built the image in the project where you have jenkins, you only need to restart jenkins for it to find the image. Jenkins will search for image streams and images with tags _role=jenkins-slave_ during start up.

## Using the image in a build

In your jenkins pipeline, you need to mark the node to be _nodejs6_ in order to use the slave image.

`node('nodejs6') {`

`  // your pipeline`

`}`

