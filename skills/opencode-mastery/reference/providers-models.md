# Providers and Models Complete Reference

Source: <https://opencode.ai/docs/providers>, <https://opencode.ai/docs/models>, <https://opencode.ai/docs/zen>, <https://opencode.ai/docs/go>

## Providers Overview

Providers are LLM service providers. OpenCode supports multiple providers configured in `opencode.json`.

## Provider Configuration

```json
{
  "provider": {
    "provider-name": {
      "options": {
        "apiKey": "${ENV_VAR}",
        "baseURL": "https://api.provider.com"
      }
    }
  },
  "disabled_providers": ["provider-to-disable"],
  "enabled_providers": ["provider-to-enable"]
}
```

## Anthropic

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "${ANTHROPIC_API_KEY}",
        "baseURL": "https://api.anthropic.com"
      }
    }
  }
}
```

### Anthropic Models

| Model | Description | Context |
|-------|-------------|---------|
| `claude-opus-4-5` | Most capable, reasoning | 200K |
| `claude-sonnet-4-6` | Balanced, good for coding | 200K |
| `claude-haiku-4` | Fast, cost-effective | 200K |
| `claude-3-5-sonnet` | Previous generation | 200K |
| `claude-3-opus` | Previous generation | 200K |

## OpenAI

```json
{
  "provider": {
    "openai": {
      "options": {
        "apiKey": "${OPENAI_API_KEY}",
        "baseURL": "https://api.openai.com/v1",
        "organization": "${OPENAI_ORG}"
      }
    }
  }
}
```

### OpenAI Models

| Model | Description | Context |
|-------|-------------|---------|
| `gpt-4-turbo` | Powerful, good for coding | 128K |
| `gpt-4` | Previous flagship | 8K |
| `gpt-3.5-turbo` | Fast, cost-effective | 16K |

## Google

```json
{
  "provider": {
    "google": {
      "options": {
        "apiKey": "${GOOGLE_API_KEY}",
        "baseURL": "https://generativelanguage.googleapis.com"
      }
    }
  }
}
```

### Google Models

| Model | Description | Context |
|-------|-------------|---------|
| `gemini-pro` | General purpose | 32K |
| `gemini-ultra` | Most capable | 32K |
| `gemini-flash` | Fast, efficient | 1M |

## DeepSeek

```json
{
  "provider": {
    "deepseek": {
      "options": {
        "apiKey": "${DEEPSEEK_API_KEY}",
        "baseURL": "https://api.deepseek.com"
      }
    }
  }
}
```

### DeepSeek Models

| Model | Description | Context |
|-------|-------------|---------|
| `deepseek-chat` | General chat | 32K |
| `deepseek-coder` | Code specialized | 32K |

## Amazon Bedrock

```json
{
  "provider": {
    "amazon-bedrock": {
      "options": {
        "region": "us-east-1",
        "accessKeyId": "${AWS_ACCESS_KEY_ID}",
        "secretAccessKey": "${AWS_SECRET_ACCESS_KEY}"
      }
    }
  }
}
```

### Bedrock Models

| Provider | Model | Description |
|----------|-------|-------------|
| Anthropic | `anthropic.claude-3-opus` | Claude 3 Opus |
| Anthropic | `anthropic.claude-3-sonnet` | Claude 3 Sonnet |
| Anthropic | `anthropic.claude-3-haiku` | Claude 3 Haiku |
| Meta | `meta.llama3-70b-instruct` | Llama 3 70B |
| Meta | `meta.llama3-8b-instruct` | Llama 3 8B |
| Mistral | `mistral.mistral-large` | Mistral Large |
| Mistral | `mistral.mistral-7b-instruct` | Mistral 7B |

## OpenAI-Compatible Providers

### Generic OpenAI-Compatible

```json
{
  "provider": {
    "custom": {
      "options": {
        "apiKey": "${CUSTOM_API_KEY}",
        "baseURL": "https://your-api.com/v1"
      }
    }
  }
}
```

### Together AI

```json
{
  "provider": {
    "together": {
      "options": {
        "apiKey": "${TOGETHER_API_KEY}",
        "baseURL": "https://api.together.xyz/v1"
      }
    }
  }
}
```

### Groq

```json
{
  "provider": {
    "groq": {
      "options": {
        "apiKey": "${GROQ_API_KEY}",
        "baseURL": "https://api.groq.com/openai/v1"
      }
    }
  }
}
```

### Cloudflare AI Gateway

```json
{
  "provider": {
    "cloudflare": {
      "options": {
        "apiKey": "${CLOUDFLARE_API_KEY}",
        "baseURL": "https://gateway.ai.cloudflare.com/v1/${ACCOUNT_ID}/${GATEWAY}"
      }
    }
  }
}
```

## OpenCode Zen (Managed Service)

OpenCode Zen provides curated models with simplified billing.

```json
{
  "provider": {
    "opencode-zen": {
      "options": {
        "apiKey": "${ZEN_API_KEY}"
      }
    }
  },
  "model": "opencode-zen/claude-sonnet-4-6"
}
```

### Zen Configuration

1. Sign up at <https://opencode.ai/zen>
2. Get API key from dashboard
3. Set `ZEN_API_KEY` environment variable
4. Configure provider as above

### Zen Models

| Model | Description |
|-------|-------------|
| `opencode-zen/claude-sonnet-4-6` | Default coding model |
| `opencode-zen/claude-opus-4-5` | Premium model |
| `opencode-zen/low-cost` | Budget option |

### Zen Features

- Unified billing
- Automatic provider fallback
- Usage tracking
- Team management

## OpenCode Go (Budget Option)

```json
{
  "provider": {
    "opencode-go": {
      "options": {
        "apiKey": "${GO_API_KEY}"
      }
    }
  }
}
```

### Go Features

- Low cost subscription
- Open coding models
- Usage limits
- Pay-as-you-go

## Model Selection Guidelines

| Use Case | Recommended Model |
|----------|-------------------|
| General coding | `claude-sonnet-4-6` |
| Complex analysis | `claude-opus-4-5` |
| Fast tasks | `claude-haiku-4` |
| Budget | `google/gemini-flash` |
| Code specialized | `deepseek-coder` |

## Model Variants

### Built-in Variants

```json
{
  "model": "anthropic/claude-sonnet-4-6",
  "variants": {
    "fast": "anthropic/claude-haiku-4",
    "balanced": "anthropic/claude-sonnet-4-6",
    "powerful": "anthropic/claude-opus-4-5"
  }
}
```

### Custom Variants

```json
{
  "model": "anthropic/claude-sonnet-4-6",
  "variants": {
    "my-fast": {
      "model": "anthropic/claude-haiku-4",
      "temperature": 0.5
    }
  }
}
```

## Environment Variables for Providers

| Provider | Variable |
|----------|----------|
| Anthropic | `ANTHROPIC_API_KEY` |
| OpenAI | `OPENAI_API_KEY`, `OPENAI_ORG` |
| Google | `GOOGLE_API_KEY` |
| DeepSeek | `DEEPSEEK_API_KEY` |
| AWS (Bedrock) | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` |
| Together | `TOGETHER_API_KEY` |
| Groq | `GROQ_API_KEY` |
| Cloudflare | `CLOUDFLARE_API_KEY`, `CLOUDFLARE_ACCOUNT_ID` |
| Zen | `ZEN_API_KEY` |
| Go | `GO_API_KEY` |

## Provider Authentication Precedence

1. Config file (`provider.<name>.options.apiKey`)
2. Environment variable
3. OAuth/token from provider

## Multiple Providers

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "${ANTHROPIC_API_KEY}"
      }
    },
    "openai": {
      "options": {
        "apiKey": "${OPENAI_API_KEY}"
      }
    }
  },
  "model": "anthropic/claude-sonnet-4-6",
  "small_model": "openai/gpt-3.5-turbo"
}
```

## Model Configuration Options

```json
{
  "model": "anthropic/claude-sonnet-4-6",
  "small_model": "anthropic/claude-haiku-4",
  "temperature": 0.7,
  "top_p": 0.9
}
```

## Loading Models

Models can be loaded on demand via commands:
```bash
opencode models list
opencode run --model anthropic/claude-opus-4-5
```