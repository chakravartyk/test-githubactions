# syntax=docker/dockerfile:1.4
# DOCKER_BUILDKIT=1 docker build -f Dockerfile --build-arg TERRAFORM_VERSION=1.0.11 --build-arg TERRAGRUNT_VERSION=0.40.2 --build-arg GITHUB_OAUTH_TOKEN=$GITHUB_OAUTH_TOKEN -t tf-tg-bp-gcpcli:v0.0.1 .
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine

ARG GITHUB_OAUTH_TOKEN

# Setting defaults - can be overwritten using  `docker build --build-arg VAR_VERSION=x.y.z`
ARG TERRAFORM_VERSION="1.0.11"            # https://github.com/hashicorp/terraform/releases
ARG GRUNTWORK_INSTALLER_VERSION="v0.0.38" # https://github.com/gruntwork-io/gruntwork-installer/releases
ARG BOILERPLATE_VERSION="v0.5.3"          # https://github.com/gruntwork-io/boilerplate/releases

SHELL ["bash", "-euxo", "pipefail", "-c" ]

# Install gruntwork installer
RUN curl -Ls https://raw.githubusercontent.com/gruntwork-io/gruntwork-installer/"$GRUNTWORK_INSTALLER_VERSION"/bootstrap-gruntwork-installer.sh | bash /dev/stdin --no-sudo true --version "$GRUNTWORK_INSTALLER_VERSION"

# Install boilerplate
RUN gruntwork-install --binary-name 'boilerplate' --repo 'https://github.com/gruntwork-io/boilerplate' --tag "$BOILERPLATE_VERSION" --no-sudo true

# `file` command required by boilerpalte to run successfully (https://github.com/gruntwork-io/boilerplate/blob/d323184f59f1eb937fb9b6f7fb8ffb8ba1fc9fb5/util/file.go#L41-L51)
RUN apk --no-cache add file
