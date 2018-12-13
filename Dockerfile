FROM alpine:3.8

LABEL maintainer="Joonathan Mägi <joonathan@cloudnative.ee>"

ARG KUBECTL_URL=https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl
ARG AWS_IAM_AUTHENTICATOR_URL=https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator

ADD ${KUBECTL_URL} /usr/local/bin/kubectl
ADD ${AWS_IAM_AUTHENTICATOR_URL} /usr/local/bin/aws-iam-authenticator

RUN adduser -D -u 10000 kubernetes
RUN apk add --update ca-certificates gettext && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/aws-iam-authenticator

USER kubernetes

WORKDIR /home/kubernetes
CMD ["kubectl", "version", "--client"]