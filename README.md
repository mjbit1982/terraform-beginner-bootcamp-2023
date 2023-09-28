# Terraform Beginner Bootcamp 2023

## Semantic Versioning 

This project is going to utilize semantic versioning for its tagging.

[semver.org] (https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward-compatible manner
- **PATCH** version when you make backward compatible bug fixes
## Install the Terraform CLI 

### Consideration with the Terraform CLI changes 

The terraform CLI instillation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instrtuctions via Terraform Documentation and changed the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
### Considerations for Linux Distributions 
This project is built against Ubuntu. 
Please consider checking your Linux Distribution to see if it requires any change according to your distribution needs. 

[How to check OS version in Linux]( https://www.cyberciti.biz/faq/command-to-show-linux-version/)

Example of checking OS version:

```
$cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts 

While fixing the Terraform CLI gpg depreciations issues we noticed the instillation steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI. 

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)
- This will keep the Gitpod Task File ([.getpod.yml](.gitpod.yml)) tidy.
- This allows us to easily debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI. 

#### Shebang

A Shebang (pronouned Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash
`
ChatGPT recommeneded this format fro bash: `#!/usr/bin/env bash`
- for portability for different OS distributions 
- will search the user's PATH for the bash executable 

https://en.wikipedia.org/wiki/Shebang_(Unix)

### Execution Considerations 
When executing the bash script we can use the `./` shorthand notation to execute the bash script. 

eg. `source./bin/install_terraform_cli`

#### Linux Permissions Considerations 

In order to make our bash scripts executable wee need to change the file to be at the user mode. 
```sh
chmod u+x ./bin/install_terraform_install
```
alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace. 

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

We can list out all Enviorment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars 

In the terminal we can set using `export HELLO='world`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO= 'world' ./bin/print_message
```
Within a bash script we can set env var without writing export eg.
```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```
#### Printing Env Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars 

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you wany env vars to presist across all future bash terminals you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisiting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secret Storage.

```
gp env HELLO='world'
```
All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set en vars in the `.gitpod.yml` but this can only contain non-sensitive env vars. 