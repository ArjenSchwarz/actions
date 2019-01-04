FROM alpine:3.7

LABEL name="utils-zip"
LABEL version="1.0.0"
LABEL repository="https://github.com/ArjenSchwarz/actions"
LABEL homepage="https://github.com/ArjenSchwarz/actions/github/release"

LABEL maintainer="Arjen Schwarz <developer@arjen.eu>"
LABEL com.github.actions.name="Zip"
LABEL com.github.actions.description="Deploys all the files in a directory as a GitHub release."
LABEL com.github.actions.icon="black"
LABEL com.github.actions.color="upload"

RUN apk add --no-cache zip

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["zip"]
CMD ["--help"]