docker-compose run mytoxiproxy-configurer curl -s -XPOST -d '{"type" : "latency", "attributes" : {"latency" : 2000}}' http://mytoxiproxy:8474/proxies/mynginx/toxics
