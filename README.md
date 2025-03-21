# Qualifire Reverse Proxy Helm Chart

## Overview
[Caddy](https://caddyserver.com/) is a powerful, automated, and easy-to-use reverse proxy server. It provides automatic HTTPS, flexible configuration, and high performance.

This Helm chart deploys two Caddy-based reverse proxy services:
- `app-rp-service`: Routes traffic for `app.qualifire.ai`
- `proxy-rp-service`: Routes traffic for `proxy.qualifire.ai`


## Installation
```sh
# Adding the helm repo
helm repo add qualifire https://qualifire-dev.github.io/qualifire-rp-helm/
helm repo update

# Installing
helm install qualifire-reverse-proxy qualifire/qualifire-reverse-proxy-chart

# Installing with values overridden
helm install qualifire-reverse-proxy qualifire/qualifire-reverse-proxy-chart \
    --set proxy.reverse_proxy_hostname=qualifire-proxy.mycompany.com \
    --set app.reverse_proxy_hostname=qualifire-app.mycompany.com

# or, using a values file
helm install qualifire-reverse-proxy qualifire/qualifire-reverse-proxy-chart \
    -f my-values.yaml
```

## Upgrade
```sh
helm upgrade qualifire-reverse-proxy qualifire/qualifire-reverse-proxy-chart
```

## Uninstallation
```sh
helm uninstall qualifire-reverse-proxy
```

## Configuration (Values.yaml)

The [values.yaml](https://github.com/qualifire-dev/qualifire-rp-helm/blob/main/charts/qualifire-reverse-proxy-chart/values.yaml) is pretty straight forward. \
However, there are still a few configuration keys that you should take a look at:

| Key | Description |
|--------------------------|---------------------------------------------------------------|
| `proxy.reverse_proxy_hostname` | Client-facing hostname for the proxy service (e.g., `qualifire-proxy.mycompany.com`). |
| `app.reverse_proxy_hostname` | Client-facing hostname for the app service (e.g., `qualifire-app.mycompany.com`). |

Create your own `values.yaml` with your needed configuration, and install using the `-f my-values.yaml`


## HTTPS support
Caddy automatically provisions an HTTPS certificate, as stated in their [documentation](https://caddyserver.com/docs/automatic-https). \
However, for local networks, the certificate used will be a self-signed certificate. \
If this is the case for you, you might need to add a `verify=False` when invoking a request to your local `proxy.qualifire.ai`
<br/>
For example, in OpenAI:
```python
import httpx
from openai import OpenAI

client = OpenAI(
    api_key="your api key",
    base_url="https://qualifire-proxy.mycompany.local/api/providers/openai/",
    http_client=httpx.Client(verify=False),
)
```
