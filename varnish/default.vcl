vcl 4.1;

import std;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "127.0.0.1";
    .port = "8080";
    .probe = {
        .expected_response = 200;
        .initial = 1;
        .interval = 10s;
        .request = "GET /healthcheck HTTP/1.1" "Host: localhost" "Connection: close" "User-Agent: Varnish (healthcheck)";
        .threshold = 1;
        .timeout = 5s;
        .window = 2;
      }
}

sub vcl_recv {
  # IP = 0 indicates UNIX socket (hitch)  
  if (std.port(local.ip) == 0 && ! req.http.X-Forwarded-Proto) {
    set req.http.X-Forwarded-Proto = "https";
  }
}

sub vcl_deliver {
  if (obj.hits > 0) {
    set resp.http.X-Varnish-Cache = "HIT";
  } else {
    set resp.http.X-Varnish-Cache = "MISS";
  }
}
