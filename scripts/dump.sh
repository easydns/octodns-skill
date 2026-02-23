#!/usr/bin/env bash
# Dump existing DNS zone to YAML

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="${SKILL_DIR}/venv"
CONFIG_FILE="${SKILL_DIR}/config/production.yaml"

if [ -z "$1" ]; then
    echo "Usage: $0 <zone>"
    echo "Example: $0 example.com"
    exit 1
fi

ZONE="$1"

# Check if venv exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Error: octoDNS not installed. Run scripts/install.sh first."
    exit 1
fi

# Activate venv
source "${VENV_DIR}/bin/activate"

echo "Dumping zone: $ZONE"
echo "Output: ${SKILL_DIR}/config/${ZONE}.yaml"
echo ""

octodns-dump \
    --config-file="$CONFIG_FILE" \
    --output-dir="${SKILL_DIR}/config" \
    --zone="$ZONE"

echo ""
echo "✓ Zone dumped successfully"
