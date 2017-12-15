---
title: "Nginx spdy+ssl+pagespeed reverse proxy with Docker"
date: 2014-06-13T12:00:00+01:00
tags: ["docker","nginx","pagespeed"]
---

If you want to use nginx as a reverse proxy to your site, things are easy. Install nginx and use a configuration like this one:

```
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}
```

Now if you want to activate <a href="https://developers.google.com/speed/pagespeed/">PageSpeed</a> and <a href="http://en.wikipedia.org/wiki/SPDY">spdy</a> modules, you'll have to recompile the whole thing.

<blockquote>
  Not sure this is something you want to do.
</blockquote>

Nonetheless, stay with me because there's a Docker container for that.

<a href="https://github.com/dgageot/ngxpagespeed">ngxpagespeed</a> is a precompiled nginx with SSL, PageSpeed and Spdy support.

Use this command to start nginx on the same network stack as the host so that nginx can easily proxy webapps running directly on the host.

```bash
docker run -d --net host -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled dgageot/ngxpagespeed
```

<blockquote>
  Have fun!
</blockquote>
