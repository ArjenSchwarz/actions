FROM node:10-alpine

LABEL name="github-pages"
LABEL version="1.0.0"
LABEL repository="https://github.com/ArjenSchwarz/actions"
LABEL homepage="https://github.com/ArjenSchwarz/actions/github/pages"

LABEL maintainer="Arjen Schwarz <developer@arjen.eu>"
LABEL com.github.actions.name="Deploy to GitHub Pages"
LABEL com.github.actions.description="Deploys a directory to GitHub Pages."
LABEL com.github.actions.icon="black"
LABEL com.github.actions.color="git-branch"

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh curl

RUN npm install -g gh-pages

COPY entrypoint.sh /entrypoint.sh

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]