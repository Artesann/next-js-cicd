FROM node:19.8

COPY --chown=node . /app

USER node

WORKDIR /app

ENTRYPOINT [ "sh", "-c" ]

CMD [ "npm run start" ]