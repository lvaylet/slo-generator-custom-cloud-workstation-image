FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss@sha256:26c1f8bab9ad2cd8b5153be39eac4b2ca53758cf60df819c2b156f91354a3b3f
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
  make build-essential wget curl \
  vim nano \
  locales \
  && rm -rf /var/lib/apt/lists/*

# Configure locale to eliminate warnings on `sudo apt install`, `pyenv` and probably a lot more.
RUN echo "en_US.UTF-8 UTF-8" | tee /etc/locale.gen
RUN locale-gen

# Install Starship shell prompt
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# Customize user configuration
COPY script.sh /etc/profile.d/10-customize-user-configuration.sh
