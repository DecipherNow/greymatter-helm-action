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
