FROM python:3.6-alpine3.10

# envsubst and tools
RUN apk add --no-cache openssh-keygen gettext jq git bash coreutils curl gomplate \
  && pip install yq awscli==${AWSCLI_VERSION:-'1.16.280'}

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community git-crypt

# Install KOPS
RUN wget -q -O kops https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION:-'1.15.0'}/kops-linux-amd64 \
  && chmod +x kops \
  && mv kops /usr/local/bin/kops

# Install Kubectl
RUN wget -q -O kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl


# install helm
# RUN apk add --no-cache openssl which curl \
#   && curl -s -L https://git.io/get_helm.sh | bash

# fix "aws command not found" and also make life easier
ENV PATH="~/.local/bin:$PATH"
