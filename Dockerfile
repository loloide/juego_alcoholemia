FROM nginx
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./index.audio.worklet.js /usr/share/nginx/html/index.audio.worklet.js
COPY ./index.js /usr/share/nginx/html/index.js
COPY ./index.png /usr/share/nginx/html/index.png
COPY ./index.pck /usr/share/nginx/html/index.pck
COPY ./index.wasm /usr/share/nginx/html/index.wasm

