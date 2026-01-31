FROM alpine:latest

RUN  apk add --no-cache restic

WORKDIR /app

RUN mkdir backup

COPY entrypoint.sh restic.sh cron.conf  ./

RUN chmod +x entrypoint.sh restic.sh

RUN crontab cron.conf

CMD ["/app/entrypoint.sh"]