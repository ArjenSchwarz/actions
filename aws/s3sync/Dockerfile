FROM python:2-stretch

LABEL name="s3sync"
LABEL version="1.0.0"
LABEL repository="https://github.com/ArjenSchwarz/actions"
LABEL homepage="https://github.com/ArjenSchwarz/actions/aws/s3sync"

LABEL maintainer="Arjen Schwarz <developer@arjen.eu>"
LABEL com.github.actions.name="GitHub Action for AWS S3 Sync"
LABEL com.github.actions.description="Syncs files to an AWS S3 bucket using the S3 Tools sync command."
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="yellow"
COPY LICENSE README.md /

RUN apt-get update && apt-get install -y --no-install-recommends python-pip && \
    apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove && \
    pip install s3cmd

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]