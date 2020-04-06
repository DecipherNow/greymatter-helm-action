# Grey Matter Helm Action

A GitHub Action to package the Grey Matter Helm Charts and publish them to Nexus

## Usage

```yaml
- uses: deciphernow/greymatter-helm-action@master
  with:
    NEXUS_URL: '<nexus_url>'
    NEXUS_USER: '<nexus_user>'
    NEXUS_PASS: '<nexus_password>'
    args: '<chart'>
```

Credit to https://github.com/Flydiverny/helm-package-action for inspiration

## Docker

Images are built and tagged based on the version of helm used.  To ensure continuity use the make file to produce and publish images.

build image: `make build`
tag image: `make docker-tag`
publish image: `make docker-publish`

The make file defaults to helm version `v3.1.1` if you would like to use any other version just append `HELM_VERSION=` and the version to make commands (eg: `make build HELM_VERSION=2.15.1`)
