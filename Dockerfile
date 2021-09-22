FROM nginx
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./juego_alcoholemia.audio.worklet.js /usr/share/nginx/html/juego_alcoholemia.audio.worklet.js
COPY ./juego_alcoholemia.js /usr/share/nginx/html/juego_alcoholemia.js
COPY ./juego_alcoholemia.png /usr/share/nginx/html/juego_alcoholemia.png
COPY ./juego_alcoholemia.pck /usr/share/nginx/html/juego_alcoholemia.pck
COPY ./juego_alcoholemia.wasm /usr/share/nginx/html/juego_alcoholemia.wasm

