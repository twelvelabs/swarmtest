FROM alpine:3.5

RUN apk add --no-cache curl nano

ENTRYPOINT ["curl"]
