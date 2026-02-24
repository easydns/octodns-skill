# octoDNS Skill

AI agent wrapper for [octoDNS](https://github.com/octodns/octodns) - "DNS as code" automation for multiple providers.

## What is this?

A skill package that enables AI agents (and humans) to manage DNS zones programmatically using octoDNS. Provides:
- **Helper scripts** for common DNS operations
- **Agent-friendly documentation** (SKILL.md format)
- **Complete guides** for DNS record management, migrations, and dynamic updates
- **easyDNS provider integration** (works with 50+ other DNS providers too)

Built specifically for AI agent workflows, but accessible to humans too.

## ⚠️ CRITICAL SAFETY WARNING - READ THIS FIRST

**octoDNS treats YAML as the "desired state" of your ENTIRE zone.**

If your DNS has 50 records but your YAML only has 1 record, octoDNS will **DELETE the other 49 records** when you sync!

**📖 [Read the complete Safety Guide](SAFETY.md) before using this tool.**

**Quick safety rules:**
1. **Dump existing zones FIRST** (see step 2 below)
2. **Preview changes** before applying (`--doit`)
3. **Review the diff carefully** - look for unexpected Deletes

## Quick Start

### 1. Install

```bash
./scripts/install.sh
```

Installs octoDNS and the easyDNS provider in a local virtualenv.

### 2. Dump Existing Zone (CRITICAL FIRST STEP)

**If managing an existing zone, dump it first:**

```bash
./scripts/dump.sh example.com.
```

This creates `config/example.com.yaml` with ALL existing records. **Never skip this step for existing zones!**

### 3. Configure Credentials

Create `.credentials/easydns.json`:

```json
{
  "provider": "easydns",
  "api_token": "YOUR_TOKEN",
  "api_key": "YOUR_API_KEY",
  "portfolio": ""
}
```

### 4. Edit the Zone File

Edit `config/example.com.yaml` with your DNS records:

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

### 5. Preview Changes (Always!)

**Never skip the preview step:**
```bash
./scripts/sync.sh --zone example.com.
```

**Look for unexpected "Delete" lines in the preview!**

### 6. Apply Changes (Only When Safe)

```bash
./scripts/sync.sh --zone example.com. --doit
```

**Safety checklist before running --doit:**
- ✅ Did you dump the existing zone first?
- ✅ Did you review the preview output?
- ✅ Are the "Delete" lines expected?
- ✅ Do the record counts look right?

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
