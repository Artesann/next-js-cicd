FROM node:19.8

COPY --chown=node best-app /app

USER node

WORKDIR /app

ENTRYPOINT [ "sh", "-c" ]

CMD [ "npm run start" ]