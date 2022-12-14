FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest
# Usage:
#   Build with:
#     docker build . -t code-oss-for-slo-generator
#   Test locally with:
#     docker run --privileged -p 8080:80 code-oss-for-slo-generator
#     docker ps -q | xargs docker stop
#   Push to Container Registry or Artifact Registry with:
#     docker tag code-oss-for-slo-generator europe-west9-docker.pkg.dev/slo-generator-demo/docker/code-oss-for-slo-generator
#     docker push europe-west9-docker.pkg.dev/slo-generator-demo/docker/code-oss-for-slo-generator
#   Or use Cloud Build to build/tag/push automatically with:
#     gcloud builds submit --tag europe-west9-docker.pkg.dev/slo-generator-demo/docker/code-oss-for-slo-generator:test_cloud_build 
#
# References:
# - https://cloud.google.com/workstations/docs/customize-container-images

# Add static assets, for example packages.
# References:
# - https://techoverflow.net/2021/01/13/how-to-use-apt-install-correctly-in-your-dockerfile/
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
  make build-essential wget curl llvm xz-utils tk-dev \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  vim \
  locales \
  && rm -rf /var/lib/apt/lists/*

# Configure locale to eliminate warnings on `sudo apt install`, `pyenv` and probably a lot more.
RUN echo "en_US.UTF-8 UTF-8" | tee /etc/locale.gen
RUN locale-gen

# Customize user configuration
# IMPORTANT: The scripts must be executable. Otherwise, please run `chmod +x <script>.sh`.
# References:
# - https://cloud.google.com/workstations/docs/customize-container-images#cloud-workstations-base-image-structure
# - https://cloud.google.com/workstations/docs/customize-container-images#container_image_with_user_customization
COPY 011_customize-user.sh /etc/workstation-startup.d/
COPY script.sh /tmp/
