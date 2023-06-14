# Gateway

This repository holds the configuration needed to host an Nginx reverse proxy inside a Docker container.

We use it:

- To act as a sticky proxy for our review apps, acting as a single Oauth app in the eyes of the Github Oauth provider
- To act as a reverse proxy for Datadog (and bypass some ad-blockers)
- To act as a cache for our GraphQL API (only for requests where the caller explicitely set the X-Cache-Api header)

The reason we want to have a Docker container for this is that we want to be able to deploy it on Heroku, which is a PaaS that does not support the `nginx` buildpack.

## Manual deployment

You will need to create a Heroku account and install the Heroku CLI, eg.
`brew install heroku`.

As a prerequisitory, you must set the `OD_API_HOST` environement variable according to the
environement (develop, staging or production).

Eg.

```sh
heroku config:set OD_API_HOST=develop.hasura.onlydust.xyz -a od-gateway-develop
```

Then, deploy with the following commands (the app name depends on the environement you want to deploy to):

```sh
export DOCKER_DEFAULT_PLATFORM=linux/amd64
heroku container:push web -a od-gateway-develop
heroku container:release web -a od-gateway-develop
```

> **Note**: Since you are very likely to run this script on a Mac M1, you will need to set the `DOCKER_DEFAULT_PLATFORM` environment variable to `linux/amd64` to force the build to happen on an amd64 machine, in order for Heroku to be able to run it.

## Local testing

To test the configuration locally, you can run:

```sh
docker build -t gateway .
docker run -p 3001:3001 --env PORT=3001 --env OD_API_HOST=develop.hasura.onlydust.xyz --rm -it gateway
```

Then, you can access the proxy at http://localhost:3001.
