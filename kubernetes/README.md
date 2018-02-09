# Kubernetes Deployment Manifests

These are a set of YML files that would create the Deployment of your own containerized Clara.

### Deploying

Simply apply these using `kubetctl`, however, for the main app ``deployment-clara.yml``, you need to edit the ``env`` portion of the yml file.

Please be reminded that you should deploy the Redis Stateful set definition and the Redis service definition before deploying the bot definition.