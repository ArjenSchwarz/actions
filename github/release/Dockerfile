FROM debian:stable-slim

LABEL name="github-release"
LABEL version="1.0.1"
LABEL repository="https://github.com/ArjenSchwarz/actions"
LABEL homepage="https://github.com/ArjenSchwarz/actions/github/release"

LABEL maintainer="Arjen Schwarz <developer@arjen.eu>"
LABEL com.github.actions.name="Release to GitHub"
LABEL com.github.actions.description="Deploys all the files in a directory as a GitHub release."
LABEL com.github.actions.icon="black"
LABEL com.github.actions.color="upload"

RUN apt-get update && apt-get install -y openssl curl jq git && \
    apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# CMD ["help"]