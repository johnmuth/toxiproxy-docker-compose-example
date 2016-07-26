# toxiproxy-docker-compose-example

This is a simple demonstration of one way to use [toxiproxy](https://github.com/Shopify/toxiproxy) with [docker-compose](https://docs.docker.com/compose/).

## Why?

I wanted to test the behavior of an application when one of its dependencies - a database, a remote http API, etc. - is slow, or otherwise unreliable.

Toxiproxy seems like a perfect tool for the job but I couldn't quite get it to work with docker-compose, so I created this bare-bones project.

It might be possible to do this more simply, but it's the first thing I got working.

## Overview

Four services are defined in docker-compose.yml:

- 'timecurl' : repeatedly sends requests to ngnix via toxiproxy, and prints out the elapsed time, response code, and url. This is a stand-in for your application, the thing that will be sending requests to the thing that you want to put behind toxiproxy.
- 'mynginx' : runs a plain vanilla nginx. This is a stand-in for the thing that you want to put behind toxiproxy.
- 'mytoxiproxy' : runs toxiproxy.
- 'mytoxiproxy-configurer' : Configures the toxiproxy instance. It defines a single "proxy", to the nginx. 

## Prerequisites

- docker-compose

### How to use - straight proxy, no added latency

First, let's verify that everything works as expected with plain old straight-through proxying.

Start all the containers in detached mode.

```
docker-compose up -d
```

You should see it create one network and four containers:

```
Creating network "toxiproxydockercomposeexample_default" with the default driver
Creating toxiproxydockercomposeexample_mynginx_1
Creating toxiproxydockercomposeexample_mytoxiproxy_1
Creating toxiproxydockercomposeexample_mytoxiproxy-configurer_1
Creating toxiproxydockercomposeexample_timecurl_1
```

Now check the 'timecurl' container logs:

```
docker logs toxiproxydockercomposeexample_timecurl_1
```

You should see lines like the following:

```
0.009 200 http://mytoxiproxy:22220/
```

This is the output from the 'time-curl.sh' script.

From the above we can confirm that:

- the URL shows that it is hitting nginx via toxiproxy,
- the response code is 200, and 
- the response time is 0.009 seconds.

### Add latency

Execute the following script to add 2 seconds latency to the proxy:

```
./add-latency.sh
```

Now check the 'timecurl' logs again, and you should see that the requests are taking ~2 seconds.


