# Reverse proxy

This repository holds the configuration needed to host an Nginx reverse proxy inside a Docker container.

We use it today at OnlyDust for two reasons:

- To act as a [RFC 5861](https://www.rfc-editor.org/rfc/rfc5861.html#section-3)-compliant cache for our access to GitHub's API
- To act as a sticky proxy for our review apps, acting as a single Oauth app in the eyes of the Github Oauth provider

The reason we want to have a Docker container for this is that we want to be able to deploy it on Heroku, which is a PaaS that does not support the `nginx` buildpack.

## Manual deployment

You will need to create a Heroku account and install the Heroku CLI, eg.
`brew install heroku`.

```
git clone git@github.com:onlydustxyz/reverse-proxy.git
cd reverse-proxy
export DOCKER_DEFAULT_PLATFORM=linux/amd64
heroku container:push web -a od-reverse-proxy
heroku container:release web -a od-reverse-proxy
```

> **Note**: Since you are very likely to run this script on a Mac M1, you will need to set the `DOCKER_DEFAULT_PLATFORM` environment variable to `linux/amd64` to force the build to happen on an amd64 machine, in order for Heroku to be able to run it.

## Local testing

To test the configuration locally, you can run:

```
docker build -t reverse-proxy .
docker run -p 3000:3000 --env PORT=3000 --rm -it reverse-proxy
```

Then, you can access the proxy at http://localhost:3000.
