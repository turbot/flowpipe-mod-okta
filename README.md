# Okta Library Mod

Okta pipeline library for [Flowpipe](https://flowpipe.io), enabling seamless integration of Okta services into your workflows.

## Documentation

- **[Pipelines →](https://hub.flowpipe.io/mods/turbot/okta/pipelines)**

## Getting started

### Requirements

Docker daemon must be installed and running. Please see [Install Docker Engine](https://docs.docker.com/engine/install/) for more information.

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

### Credentials

By default, the following environment variables will be used for authentication:

- `OKTA_TOKEN`
- `OKTA_ORGURL`

You can also create `credential` resources in configuration files:

```sh
vi ~/.flowpipe/config/okta.fpc
```

```hcl
credential "okta" "okta_cred" {
  domain    = "https://test.okta.com"
  api_token = "00B63........"
}
```

For more information on credentials in Flowpipe, please see [Managing Credentials](https://flowpipe.io/docs/run/credentials).

### Usage

List pipelines:

```sh
flowpipe pipeline list
```

Run a pipeline:

```sh
flowpipe pipeline run get_application
```

You can pass in pipeline arguments as well:

```sh
flowpipe pipeline run get_application --arg app_id=oab1cdefghijklmno0
```

To use a specific `credential`, specify the `cred` pipeline argument:

```sh
flowpipe pipeline run get_application --arg app_id=oab1cdefghijklmno0 --arg cred=okta_cred
```

For more examples on how you can run pipelines, please see [Run Pipelines](https://flowpipe.io/docs/run/pipelines).

### Configuration

No additional configuration is required.

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Flowpipe](https://flowpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #flowpipe on Slack →](https://flowpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Flowpipe](https://github.com/turbot/flowpipe/labels/help%20wanted)
- [Okta Mod](https://github.com/turbot/flowpipe-mod-okta/labels/help%20wanted)
