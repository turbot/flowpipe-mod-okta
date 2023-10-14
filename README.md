# Okta Library Mod for Flowpipe

Run pipelines and use triggers for Okta resources.

The Flowpipe Okta Mod is a versatile and easy-to-use workflow automation tool designed to streamline Okta-related tasks. This mod is a part of the Flowpipe ecosystem, which focuses on providing low-code, modular, and lightweight solutions for your Okta workflow automation needs.

# Documentation

- [Okta Library Mod](https://hub.flowpipe.io/mods/turbot/okta)
- [Pipelines](https://hub.flowpipe.io/mods/turbot/okta/pipelines)

## Getting started

### Installation

Download and install Flowpipe (https://flowpipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install flowpipe
```

Clone:

```sh
git clone https://github.com/turbot/flowpipe-mod-okta.git
cd flowpipe-mod-okta
```

### Usage

Start your server to get started:

```sh
flowpipe service start
```

Run a pipeline:

```sh
flowpipe pipeline run get_user
```

### Credentials

This mod uses the credentials configured in `flowpipe.pvars` or passed through `--pipeline-args api_token`.

### Configuration

Pipelines have [input variables](https://flowpipe.io/docs/using-flowpipe/mod-variables) that can be configured to better match your environment and requirements. Some variables have defaults defined in its source file, e.g., `variables.hcl`, but these can be overwritten in several ways:

- Copy and rename the `flowpipe.pvars.example` file to `flowpipe.pvars`, and then modify the variable values inside that file
- Pass in a value on the command line:

  ```shell
  flowpipe pipeline run get_user --pipeline-arg api_token="00BxxxxxxxxxQMAdqizwE2OgVcS7N9UHb" --pipeline-arg user_id="00ucxxxxxxJRtiJz5d7"
  ```

These are only some of the ways you can set variables. For a full list, please see [Passing Input Variables](https://flowpipe.io/docs/using-flowpipe/mod-variables#passing-input-variables).

## Contributing

If you have an idea for additional controls or just want to help maintain and extend this mod ([or others](https://Okta.com/topics/flowpipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://flowpipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://Okta.com/turbot/flowpipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://Okta.com/turbot/flowpipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://Okta.com/turbot/flowpipe-mod-Okta/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Flowpipe](https://Okta.com/turbot/flowpipe/labels/help%20wanted)
- [Okta Library Mod](https://Okta.com/turbot/flowpipe-mod-Okta/labels/help%20wanted)
