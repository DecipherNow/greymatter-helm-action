FROM alpine:3.10

LABEL "name"="greymatter-helm-action"
LABEL "maintainer"="sres@deciphernow.com"
LABEL "version"="0.1.0"

LABEL "com.github.actions.name"="Grey Matter Helm Package"
LABEL "com.github.actions.description"="Action for packaging and publishing the Grey Matter Helm Charts"
LABEL "com.github.actions.color"="green"
LABEL "com.github.actions.icon"="package"

ARG K8S_VERSION=v1.16.2
ARG HELM_VERSION=v2.15.1
ENV HELM_HOME=/usr/local/helm
ENV INPUT_NEXUS_URL https://nexus.com
ENV INPUT_NEXUS_USER username
ENV INPUT_NEXUS_PASS password

RUN apk -v --update --no-cache add \
  ca-certificates \
  bash \
  curl

RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl

RUN wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
  chmod +x /usr/local/bin/helm

RUN helm init --client-only

COPY ./entrypoint.sh /usr/bin/entrypoint

ENTRYPOINT ["entrypoint"]
CMD ["help"]