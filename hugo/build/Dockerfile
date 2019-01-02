FROM debian:stable-slim
LABEL name="hugo-build"
LABEL version="1.0.0"
LABEL repository="https://github.com/ArjenSchwarz/actions"
LABEL homepage="https://github.com/ArjenSchwarz/actions/hugo/build"

LABEL maintainer="Arjen Schwarz <developer@arjen.eu>"
LABEL com.github.actions.name="GitHub Action for Hugo"
LABEL com.github.actions.description="Builds a Hugo site."
LABEL com.github.actions.icon="sidebar"
LABEL com.github.actions.color="purple"
COPY LICENSE README.md /
RUN apt-get update && apt-get install -y openssl curl jq && \
    apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--verbose"]