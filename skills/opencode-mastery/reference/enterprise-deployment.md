# Enterprise and Deployment Complete Reference

Source: <https://opencode.ai/docs/enterprise>, <https://opencode.ai/docs/server>, <https://opencode.ai/docs/network>

## Enterprise Overview

OpenCode Enterprise provides:
- Advanced security
- Team management
- Centralized configuration
- SSO integration
- Self-hosting options

## Enterprise Features

### Security

- Data handling policies
- Sharing conversation controls
- Code ownership
- Private deployment options

### Team Management

- Role-based access control
- Model access controls
- Bring your own key (BYOK)
- Usage tracking and limits

### Deployment Options

- Cloud-hosted
- On-premise
- Hybrid
- Air-gapped (offline)

## Pricing

Contact: mailto:contact@anoma.ly

## Central Config

### Organization-wide Configuration

```json
{
  "enterprise": {
    "org_id": "org-12345",
    "config_url": "https://config.company.com/opencode.json"
  }
}
```

### Config Sync

Configs auto-sync from central server.

## SSO Integration

### SAML

```json
{
  "enterprise": {
    "sso": {
      "type": "saml",
      "idp_url": "https://idp.company.com/saml",
      "certificate": "${SSO_CERT}"
    }
  }
}
```

### OIDC

```json
{
  "enterprise": {
    "sso": {
      "type": "oidc",
      "issuer": "https://idp.company.com",
      "client_id": "${OIDC_CLIENT_ID}",
      "client_secret": "${OIDC_CLIENT_SECRET}"
    }
  }
}
```

## Internal AI Gateway

```json
{
  "enterprise": {
    "ai_gateway": {
      "url": "https://ai-gateway.internal.company.com",
      "token": "${AI_GATEWAY_TOKEN}"
    }
  }
}
```

## Self-Hosting

### Docker

```bash
# Pull image
docker pull opencodeai/opencode:latest

# Run
docker run -d \
  -p 4096:4096 \
  -v opencode-data:/data \
  -e OPENCODE_API_KEY="${API_KEY}" \
  opencodeai/opencode:latest
```

### Docker Compose

```yaml
version: '3.8'
services:
  opencode:
    image: opencodeai/opencode:latest
    ports:
      - "4096:4096"
    volumes:
      - opencode-data:/data
    environment:
      - OPENCODE_API_KEY=${API_KEY}
      - OPENCODE_AUTH_ENABLED=true
    restart: unless-stopped

volumes:
  opencode-data:
```

### Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: opencode
spec:
  replicas: 3
  selector:
    matchLabels:
      app: opencode
  template:
    metadata:
      labels:
        app: opencode
    spec:
      containers:
      - name: opencode
        image: opencodeai/opencode:latest
        ports:
        - containerPort: 4096
        env:
        - name: OPENCODE_API_KEY
          valueFrom:
            secretKeyRef:
              name: opencode-secret
              key: api-key
```

## Server Configuration

### Basic Server

```bash
opencode serve --port 4096
```

### With Auth

```bash
opencode serve --port 4096 --auth
```

### With CORS

```bash
opencode serve --port 4096 --cors
```

### Full Configuration

```json
{
  "server": {
    "port": 4096,
    "hostname": "0.0.0.0",
    "auth": true,
    "cors": {
      "enabled": true,
      "origins": ["https://app.company.com"]
    },
    "ssl": {
      "enabled": true,
      "cert": "/path/to/cert.pem",
      "key": "/path/to/key.pem"
    }
  }
}
```

### Server Options

| Option | Description | Default |
|--------|-------------|---------|
| `port` | Server port | 4096 |
| `hostname` | Bind address | localhost |
| `auth` | Enable auth | false |
| `cors` | Enable CORS | false |
| `ssl` | Enable SSL | false |

## Network Configuration

### Proxy Support

```json
{
  "network": {
    "proxy": {
      "url": "http://proxy.company.com:8080",
      "auth": {
        "username": "${PROXY_USER}",
        "password": "${PROXY_PASS}"
      },
      "bypass": ["*.internal.company.com"]
    }
  }
}
```

### Environment Variables

```bash
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"
export NO_PROXY="localhost,127.0.0.1"
```

### Custom Certificates

```json
{
  "network": {
    "custom_certs": [
      "/path/to/cert1.pem",
      "/path/to/cert2.pem"
    ]
  }
}
```

### CLI Proxy Flags

```bash
opencode --proxy http://proxy.company.com:8080
opencode --proxy-auth user:pass
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENCODE_API_KEY` | API key for authentication |
| `OPENCODE_AUTH_ENABLED` | Enable server auth |
| `OPENCODE_SSL_ENABLED` | Enable SSL |
| `OPENCODE_DATA_DIR` | Data directory |
| `HTTP_PROXY` | HTTP proxy URL |
| `HTTPS_PROXY` | HTTPS proxy URL |
| `NO_PROXY` | Bypass proxy |

## Backup and Recovery

### Backup Data

```bash
# Export data
tar -czf opencode-backup.tar.gz ~/.config/opencode/

# Or use built-in
opencode export --backup
```

### Restore Data

```bash
# Stop server
opencode serve --stop

# Restore
tar -xzf opencode-backup.tar.gz -C ~/

# Restart
opencode serve
```

## Monitoring

### Health Check

```bash
curl http://localhost:4096/health
```

### Metrics

```bash
curl http://localhost:4096/metrics
```

### Logs

```bash
tail -f ~/.config/opencode/logs/opencode.log
```

## Scaling

### Horizontal Scaling

Run multiple instances behind load balancer:

```yaml
services:
  opencode:
    image: opencodeai/opencode:latest
    deploy:
      replicas: 3
```

### Load Balancer Config

```nginx
upstream opencode {
    server opencode-1:4096;
    server opencode-2:4096;
    server opencode-3:4096;
}

server {
    listen 443 ssl;
    server_name opencode.company.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://opencode;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## FAQ

### Q: How to update self-hosted?
```bash
docker pull opencodeai/opencode:latest
docker-compose down
docker-compose up -d
```

### Q: How to migrate data?
```bash
# Export from old
opencode session export --all > backup.json

# Import to new
opencode session import backup.json
```

### Q: How to enable audit logs?
```json
{
  "enterprise": {
    "audit_logs": {
      "enabled": true,
      "endpoint": "https://logs.company.com/opencode"
    }
  }
}
```

### Q: How to restrict model access?
```json
{
  "enterprise": {
    "model_access": {
      "allowed": ["anthropic/claude-sonnet-4-6"],
      "blocked": ["anthropic/claude-opus-4-5"]
    }
  }
}
```