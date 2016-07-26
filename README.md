# toxiproxy-docker-compose-example

This is a simple demonstration of one way to use [toxiproxy](https://github.com/Shopify/toxiproxy) with [docker-compose](https://docs.docker.com/compose/).

## Why?

I wanted to test the behavior of an application when one of its dependencies - a database, a remote http API, etc. - is slow, or otherwise unreliable.

Toxiproxy is a TCP proxy between your application and any dependency.

But I couldn't quite get it to work with docker-compose, so I created this bare-bones project.

It might be possible to do this more simply, but it's the first thing I got working.

## Overview

Four services are defined in docker-compose.yml:

- 'timecurl' : repeatedly sends requests to ngnix via toxiproxy, and prints out the elapsed time, response code, and url. This is a stand-in for your application, the thing that will be sending requests to the thing that you want to put behind toxiproxy.
- 'mynginx' : runs a plain vanilla nginx. This is a stand-in for the thing that you want to put behind toxiproxy.
- 'mytoxiproxy' : runs toxiproxy.
- 'mytoxiproxy-configurer' : Configures the toxiproxy instance. It defines a single "proxy", to the nginx. 

## Prerequisites

- docker-compose

## How to use

```
docker-compose up
```

If you see lines like the following, it is working:

```
timecurl_1                | 0.009 200 http://mytoxiproxy:22220/
```

This shows output from the container 'timecurl_1', which prints out the time, response code, and url. 
The response code is 200, and the URL shows that it is hitting nginx via toxiproxy.

## TODO

- add a delay to the proxy


