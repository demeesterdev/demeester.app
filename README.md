# demeester.app
site showing all my projects published under demeester.app
This is the entrypoint for creating building a new services within demeester.app

New projects are deployed and constructed using terraform and terraform cloud.
Shared infra is available in [infra](./infra).

Shared infra contains DNS domain, key store, artifacts account and an acme registration
Shared infra is deployed trough terraform cloud and the project is managed via terraform cloud.

#managing projects.

Creating new projects and managing projects is done from the projects folder.
The project can only run locally because it bootstraps the base layer for projects.
the deployement needs tokens for terraform and github so we need some extra steps for that as well:

## adding a new project

edit the pist of projects in [./projects/variables.tf] to match the required output

login to az tf and github.
```
terraform login
az login
gh auth login
```
connect the terraform cloud inlog to tfe provider:
```pwsh
$env:TERRAFORM_CONFIG = (resolve-path "~/appdata/roaming/terraform.d/credentials.tfrc.json")
```

get the gh token from the host file
from pwsh
```pwsh
$null = "$(get-content (resolve-path "~/.config/gh/hosts.yml"))" -match "oauth_token: (?<token>\w+)"
$env:GITHUB_TOKEN = $matches["token"] 
```

if we stick it all together:
```
terraform login
az login
gh login

$env:TERRAFORM_CONFIG = (resolve-path "~/appdata/roaming/terraform.d/credentials.tfrc.json")

$null = "$(get-content (resolve-path "~/.config/gh/hosts.yml"))" -match "oauth_token: (?<token>\w+)"
$env:GITHUB_TOKEN = $matches["token"] 
```