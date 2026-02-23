#!/usr/bin/env bash
# Sync DNS zones using octoDNS

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="${SKILL_DIR}/venv"
CONFIG_FILE="${SKILL_DIR}/config/production.yaml"

# Check if venv exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Error: octoDNS not installed. Run scripts/install.sh first."
    exit 1
fi

# Activate venv
source "${VENV_DIR}/bin/activate"

# Load easyDNS credentials
source "${SCRIPT_DIR}/load_credentials.sh"

# Default to dry-run (no --doit flag)
MODE=""
ZONE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --doit)
            MODE="--doit"
            shift
            ;;
        --zone)
            ZONE="$2"
            shift 2
            ;;
        --config)
            CONFIG_FILE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--doit] [--zone ZONE] [--config FILE]"
            echo ""
            echo "  (no flags)  = dry-run (preview only)"
            echo "  --doit      = actually apply changes"
            exit 1
            ;;
    esac
done

# Build command
CMD="octodns-sync --config-file=$CONFIG_FILE $MODE"

if [ -n "$ZONE" ]; then
    CMD="$CMD $ZONE"
fi

echo "Running: $CMD"
echo ""

# Execute
$CMD
