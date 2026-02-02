FROM alpine:3

ENV TZ=America/Montreal

RUN  apk add --no-cache restic tzdata

WORKDIR /app

RUN mkdir backup

COPY entrypoint.sh restic.sh cron.conf  ./

RUN chmod +x entrypoint.sh restic.sh

RUN crontab cron.conf

CMD ["/app/entrypoint.sh"]
