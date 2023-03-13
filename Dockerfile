FROM nginx:1.23.3

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY decode_uri.js /etc/nginx/njs/decode_uri.js
COPY nginx.conf /etc/nginx/nginx.conf

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
