FROM alpine:3.7

LABEL name="utils-zip"
LABEL version="1.0.0"
LABEL repository="https://github.com/ArjenSchwarz/actions"
LABEL homepage="https://github.com/ArjenSchwarz/actions/github/release"

LABEL maintainer="Arjen Schwarz <developer@arjen.eu>"
LABEL com.github.actions.name="Zip"
LABEL com.github.actions.description="Zip files."
LABEL com.github.actions.icon="blue"
LABEL com.github.actions.color="box"

RUN apk add --no-cache zip

ENTRYPOINT ["zip"]
CMD ["--help"]