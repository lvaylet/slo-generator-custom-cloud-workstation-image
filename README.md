# Custom Cloud Workstation Image for SLO Generator Development

This is an example of how to create a custom Cloud Workstation image by extending a preconfigured base image, as detailed in the [official documentation](https://cloud.google.com/workstations/docs/customize-container-images).

The repository is configured to build and push a new Docker image to Artifact Registry on every push to the `main` branch. Then the image can be used to create a new Configuration in Cloud Workstations (or update an existing Configuration).

## Final Steps

Once the Workstation is started, finalize the environment with:

```sh
# Install Python and enable it globally.
pyenv install 3.9.15
pyenv global 3.9.15

# Generate SSH keys for GitHub.
ssh-keygen -t ed25519 -C "laurent.vaylet@gmail.com" -f "${HOME}/.ssh/id_ed25519" -q -N ""
cat "${HOME}/.ssh/id_ed25519.pub"
# At this point, add the public key to https://github.com/settings/keys

# Clone the SLO Generator repository.
mkdir -p "${HOME}/workspace/github/google"
cd "${HOME}/workspace/github/google"
git clone git@github.com:google/slo-generator.git
cd slo-generator

# Create a virtual environment.
python -m venv .venv/
source .venv/bin/activate

# Install dependencies and run tests.
make all

# Confirm SLO Generator can be called.
slo-generator
```

## References

- [Cloud Build - GitHub Actions](https://github.com/google-github-actions/setup-gcloud/blob/main/example-workflows/cloud-build/README.md) for how to use Cloud Build from GitHub.
- [Deploy GCP Resources with Terraform from GitHub with Keyless Authentication](https://github.com/lvaylet/terraform-in-action) for how to authenticate from GitHub without a Service Account JSON key.

## TODO

- Push to Artifact Registry instead of Container Registry
