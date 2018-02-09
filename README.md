# Clara on Container

Whoop whoop! This is the first-ever Discord bot that is open source to run on containers.

The following is the raw Dockerfiles used to build the containers for Clara, with two flavors.

### Installing

You simply need Docker installed or a [Kubernetes](https://kubernetes.io) Node.

For Docker installations, simply pull from:

- Clarity LLC Repositories
   -  ``claritymoe/clara:ubuntu``
   -  ``claritymoe/clara:alpine``

- Capuccino's DockerHub repository
   -  ``chinodesuuu/clara:ubuntu``
   -  ``chinodesuuu/clara:alpine``
 
(Note: To use code from the ``development`` branch of the Discord bot, simply add ``-nightly`` on the tag reference, ie. ``chinodesuuu/clara:alpine-nightly``)

### Automated Builds

This repository builds from source every Saturday at Japanese time (JST) using CircleCI.

### Kubernetes Deployments

Go to ``/kubernetes`` for information regarding deploying Clara on Kubernetes.