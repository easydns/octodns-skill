#!/usr/bin/env bash
# Dump existing DNS zone to YAML

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="${SKILL_DIR}/venv"
CONFIG_FILE="${SKILL_DIR}/config/production.yaml"

if [ -z "$1" ]; then
    echo "Usage: $0 <zone> [provider]"
    echo "Example: $0 example.com easydns"
    echo "         $0 example.com route53"
    echo ""
    echo "If provider is not specified, uses 'easydns' by default"
    exit 1
fi

ZONE="$1"
PROVIDER="${2:-easydns}"

# Check if venv exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Error: octoDNS not installed. Run scripts/install.sh first."
    exit 1
fi

# Activate venv
source "${VENV_DIR}/bin/activate"

echo "================================================================"
echo "  DUMPING EXISTING ZONE - CRITICAL SAFETY STEP"
echo "================================================================"
echo "Zone: $ZONE"
echo "Provider: $PROVIDER"
echo "Output: ${SKILL_DIR}/config/${ZONE}.yaml"
echo ""
echo "This captures ALL existing records in the zone."
echo "ALWAYS do this before making changes to existing zones!"
echo ""

# Load credentials if provider is easydns
if [ "$PROVIDER" = "easydns" ]; then
    source "${SCRIPT_DIR}/load_credentials.sh"
fi

octodns-dump \
    --config-file="$CONFIG_FILE" \
    --output-dir="${SKILL_DIR}/config" \
    "$ZONE" \
    "$PROVIDER"

echo ""
echo "✓ Zone dumped successfully"
