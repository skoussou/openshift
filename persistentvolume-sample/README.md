# persistentvolume-sample

# Sample Application for Persistent Volumes

This is a very basic application to work with persistent volumes. The application 
itself does not take use of the persistent volume.

---

## Lab Instructions

At first we are going to create and deploy an extremely simple web site using 
the out-of-the-box Apache 2.4 image available from the repository. After we 
have the application up and running we will attach a persistent volume to the 
running pod. Finally we are going to demonstrate
persistence with simple file operations.

In the instructions below replace _$username_ with your own username or initials.

### Clone the git repository

Clone the git repostitory to local disc.

`git clone https://github.com/jmetso/openshift/tree/master/persistentvolume-sample.git`

Navigate to the _persistentvolume-sample_-directory.

### Creating and Deploying the Application

First create a new project:

`oc new-project $username-test`

Or if you already have a test project you can use that.

Then create a new build:

`oc new-build -i httpd-24-rhel7:latest -binary=true --name=$username-apache-test -l app=$username-apache-test`

Then we will start a build for the application:

`oc start-build $username-apache-test --from-dir=./html`

After the build is finished we can deploy the application image:

`oc new-app -i $username-apache-test --name=$username-apache-test -l app=$username-apache-test`

Reference build configuration is available in [bc/jme-apache-test.yaml](bc/jme-apache-test.yaml).

### Create and Add a Persistent Volume Claim to the Application

A persistent volume claim (or pvc) reserves a persistent volume (pv) for the 
application. The claim is bound to a persistent volume. The contents of a 
persistent volume will survive across pod restarts and the contents are shared
across all pods that use the same deployment configuration. The persistent 
volume is bound to the application as long as the claim exists. When the claim 
is deleted, the persistent volume will return to the pool. Depending on the 
platform configuration the contents of the persistent volume are either deleted 
or preserved.

__NOTE:__ if the same claim is recreated it will get a fresh persistent volume 
with no content.

There are two ways to create a persistent volume:

1. Create from a yaml-file: `oc create -f pvc/jme-apache-test.yaml`. Before you 
create the claim edit the __claim name__ in the file to suit your $username and
project name.

2. Use the web console: _Project Overview -> Storage -> Create Storage_. On the 
page give it a __Name__ ($username-apache-test) and select __Access Mode__, in this case _Single User (RWO)_
and give it a size of _5 MiB_.

Next we add the claim to the deployment configuration of the application above. Again there are two options:

1. Edit the deployment configuration: `oc edit dc $username-apache-test`. Insert
the snippet from [dc/volume-mount-snippet.yaml](dc/volume-mount-snippet.yaml) to __volumeMounts__ section and the
snippet from [dc/volume-snippet.yaml](dc/volume-snippet.yaml) to __volumes__ section. 
You need to change the __claimName__ to what you specified when you created the claim.
Pay special attention to indentation of the file. Remember to change `$username`.
As a reference, you can have a look at 
[dc/jme-apache-test-w-pvc.yaml](dc/jme-apache-test-w-pvc.yaml).

2. Using the web console: _Project Overview -> Applications -> Deployments -> $username-apache-tst -> Add storage_. 
In the __Add Storage__ page select your storage ($username-apache-test) and give
it a mount path _/mnt_. You can leave the volume name empty. Finally click __Add__.

After you have added the storage, the application should redeploy automatically. If the application not redeploy automatically, trigger a new deployment manually.

__NOTE:__ Adding the persistent volume to a path will replace all contents of the folder with the contents of the persistent volume.

### Demonstrate Persistence

After the application is back up and running, log in to the pod:

`oc rsh $podname` or _Project Overview -> Applications -> Pods -> $username-apache-test-number-hexstring (for example jme-apache-test-2-649ox) -> Terminal_

In the terminal, create two files:

`touch /opt/app-root/src/test.file`

and

`touch /mnt/test.file`

After you have created the files logout from the shell and kill the pod:

`oc delete pod $podname` or _Project Overview -> Applications -> Pods -> $username-apache-test-number-hexstring (for example jme-apache-test-2-649ox)-> Actions -> Delete -> Delete_

Wait for a new pod to appear for the same application. This should also happen automatically.

Login to the new pod and look for the files:

`ls /opt/app-root/src`  
`ls /mnt`

You should see that file _/mnt/test.file_ still exists, but file _/opt/app-root/src/test.file_
does not. The second file disappeared because it is not part of the source image
created earlier in the build phase.

As a bonus round you can delete the persistent volume claim and recreate it.
Then restart the pod. Finally login to the pod and observer that the files 
that we created previously have disappeared.
