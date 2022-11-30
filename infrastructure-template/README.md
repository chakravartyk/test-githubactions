# Infrastructre GitOps Template
Boilerplate Template to generate deploy configurations for GitOps

## Environments directory
Includes argocd and ska deploy configuration for an environment defined in the `{{ delivery }}_config_vars.yml` file

## Blueprints directory
Contains  `boilerplate.yml` file to configure boilerplate.

## Templates directory
Contains yaml templates for all the deploy configurations. Placeholder variables are replaced by the corresponding value from `{{ delivery }}_config_vars.yml`, else replaced by the `default` value specified in `boilerplate.yml`

## Generate output

Generate output by the running the `boilerplate` command. Output configuration will be generated under `{{ cloudProvider }}/{{ delivery }}/{{ environment }}` as defined in the config_vars.yml file.

```bash
boilerplate --template-url ./infrastructure-template/blueprints --output-folder .  --var-file ./infrastructure-template/environments/{{ delivery }}/{{ delivery }}_config_vars.yml --non-interactive
```
## Run pre-commit checks

Run the below command from the root directory to fix lint errors

```bash
pre-commit run --files {{ cloudProvider}}/{{ delivery }}/{{ environment }}/*   {{ cloudProvider}}/{{ delivery }}/{{ environment }}/bootstrap/argocd/*   {{ cloudProvider}}/{{ delivery }}/{{ environment }}/bootstrap/ska/*

```
                