# Qualifire Reverse Proxy Helm Chart

## Overview
[Caddy](https://caddyserver.com/) is a powerful, automated, and easy-to-use reverse proxy server. It provides automatic HTTPS, flexible configuration, and high performance.

This Helm chart deploys two Caddy-based reverse proxy services:
- `app-rp-service`: Routes traffic for `app.qualifire.ai`
- `proxy-rp-service`: Routes traffic for `proxy.qualifire.ai`

## Installation
```sh
helm install qualifire-reverse-proxy-chart ./qualifire-reverse-proxy-chart --values ./qualifire-reverse-proxy-chart/values.yaml
```

## Upgrade
```sh
helm upgrade qualifire-reverse-proxy-chart ./qualifire-reverse-proxy-chart --values ./qualifire-reverse-proxy-chart/values.yaml
```

## Uninstallation
```sh
helm uninstall qualifire-reverse-proxy-chart
```

## Configuration (Values.yaml)

The values.yaml are pretty straight forward. \
However, there are still a few configuration keys that you should take a look at:

| Key | Description |
|--------------------------|---------------------------------------------------------------|
| `proxy.reverse_proxy_hostname` | Client-facing hostname for the proxy service (e.g., `qualifire-proxy.mycompany.com`). |
| `app.reverse_proxy_hostname` | Client-facing hostname for the app service (e.g., `qualifire-app.mycompany.com`). |

Modify `values.yaml` to customize these (and more) values before deployment.


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
