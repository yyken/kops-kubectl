FROM python:3.6-alpine3.10

# envsubst and tools
RUN apk add --no-cache openssh-keygen gettext jq git bash coreutils curl gomplate \
  && ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' \
  && pip install yq awscli==${AWSCLI_VERSION:-'1.16.250'}

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community git-crypt

# Install KOPS
RUN wget -q -O kops https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION:-'1.14.0'}/kops-linux-amd64 \
  && chmod +x kops \
  && mv kops /usr/local/bin/kops

# Install Kubectl
RUN wget -q -O kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION:-'v1.14.8'}/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl

# Install Kustomize
RUN wget -q -O kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION:-'3.3.0'}/kustomize_${KUSTOMIZE_VERSION:-'3.1.0'}_linux_amd64 \
  && chmod +x ./kustomize \
  && mv ./kustomize /usr/local/bin/kustomize

# install helm
# RUN apk add --no-cache openssl which curl \
#   && curl -s -L https://git.io/get_helm.sh | bash

# fix "aws command not found" and also make life easier
ENV PATH="~/.local/bin:$PATH"
