FROM ubuntu:latest
ARG TOFU_VERSION

# Устанавливаем необходимые зависимости и OpenTofu
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    gnupg \
    jq \
    openssh-client \
    unzip \
    && curl -Lo ./install-opentofu.sh  https://get.opentofu.org/install-opentofu.sh \
    && chmod +x ./install-opentofu.sh \
    && curl -Lo ./cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 \
    && chmod +x ./cosign \
    && mv ./cosign /usr/local/bin/cosign

# Скачивает в /opt/opentofu и устанавливает симлинк на /usr/local/bin/opentofu
RUN ./install-opentofu.sh --install-method standalone --opentofu-version ${TOFU_VERSION} \
    && rm -f ./install-opentofu.sh

# Указываем, что контейнер не будет выполнять никаких действий сам по себе
CMD ["sh"]