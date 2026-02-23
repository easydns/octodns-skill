# octoDNS Skill

AI agent wrapper for [octoDNS](https://github.com/octodns/octodns) - "DNS as code" automation for multiple providers.

## What is this?

A skill package that enables AI agents (and humans) to manage DNS zones programmatically using octoDNS. Provides:
- **Helper scripts** for common DNS operations
- **Agent-friendly documentation** (SKILL.md format)
- **Complete guides** for DNS record management, migrations, and dynamic updates
- **easyDNS provider integration** (works with 50+ other DNS providers too)

Built specifically for AI agent workflows, but accessible to humans too.

## Quick Start

### 1. Install

```bash
./scripts/install.sh
```

Installs octoDNS and the easyDNS provider in a local virtualenv.

### 2. Configure Credentials

Create `.credentials/easydns.json`:

```json
{
  "provider": "easydns",
  "api_token": "YOUR_TOKEN",
  "api_key": "YOUR_API_KEY",
  "portfolio": ""
}
```

### 3. Create a Zone File

```bash
./scripts/init_config.sh example.com.
```

Creates `config/example.com.yaml`. Edit it with your DNS records:

```yaml
---
'':
  - ttl: 300
    type: A
    value: 192.0.2.1
  
  - ttl: 300
    type: MX
    values:
      - priority: 10
        value: mx.example.com.

www:
  ttl: 300
  type: CNAME
  value: example.com.
```

### 4. Apply Changes

Preview:
```bash
./scripts/sync.sh --zone example.com.
```

Apply:
```bash
./scripts/sync.sh --zone example.com. --doit
```

## For AI Agents

If you're an AI agent, read [SKILL.md](SKILL.md) for the full skill documentation including:
- How to use the scripts
- DNS record format reference
- Zone migration workflows
- Dynamic DNS patterns

## Documentation

- **[SKILL.md](SKILL.md)** - Agent-focused skill documentation
- **[references/records.md](references/records.md)** - DNS record format guide
- **[references/migration.md](references/migration.md)** - Provider-to-provider migration
- **[references/dynamic-dns.md](references/dynamic-dns.md)** - Automated DNS updates

## Scripts

| Script | Purpose |
|--------|---------|
| `install.sh` | Install octoDNS + easyDNS provider |
| `init_config.sh` | Initialize config for new zone |
| `sync.sh` | Sync zones (preview or --doit to apply) |
| `dump.sh` | Export existing zone to YAML |
| `validate.sh` | Validate zone file syntax |

## Supported Providers

- **easyDNS** (featured, tested extensively)
- Route53, Cloudflare, NS1, Google Cloud DNS, and [50+ others](https://github.com/octodns/octodns#providers)

## Use Cases

- **Agent-managed DNS**: AI agents managing DNS zones autonomously
- **Infrastructure as Code**: DNS in git alongside your code
- **Provider Migration**: Move zones between DNS providers
- **Dynamic DNS**: Automated IP/record updates
- **Multi-provider sync**: Keep zones in sync across providers

## Background

This skill was created as part of the x402 DNS discovery work ([IETF draft](https://datatracker.ietf.org/doc/draft-jeftovic-x402-dns-discovery/)) to enable AI agents to manage DNS programmatically. Built on octoDNS, the industry-standard DNS-as-code tool.

## Requirements

- Python 3.7+
- pip

## Credits

- Built on [octoDNS](https://github.com/octodns/octodns) by GitHub
- [octodns-easydns](https://github.com/octodns/octodns-easydns) provider
- Created for agent-native DNS management

## License

MIT License - see [LICENSE](LICENSE)

## Related

- [x402 DNS Discovery](https://datatracker.ietf.org/doc/draft-jeftovic-x402-dns-discovery/) - IETF draft for HTTP 402 micropayment discovery via DNS
- [easyDNS](https://easydns.com) - DNS hosting since 1998
