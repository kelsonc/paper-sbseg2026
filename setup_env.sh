#!/usr/bin/env bash
set -euo pipefail

PYTHON_BIN="${PYTHON_BIN:-python3}"
VENV_DIR="${VENV_DIR:-.venv}"

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
    echo "Error: $PYTHON_BIN was not found. Install Python 3.8 or newer and try again." >&2
    exit 1
fi

"$PYTHON_BIN" - <<'PY'
import sys

if sys.version_info < (3, 8):
    raise SystemExit("Python 3.8 or newer is required.")

print("Python:", sys.version.split()[0])
PY

"$PYTHON_BIN" -m venv "$VENV_DIR"
. "$VENV_DIR/bin/activate"

python -m pip install --upgrade "pip<25.1"
python -m pip install -r requirements.txt

python -m ipykernel install --user --name sbseg2026 --display-name "Python (SBSeg 2026)"

echo "Environment created successfully in $VENV_DIR"
echo "Activate it with: source $VENV_DIR/bin/activate"
echo "Start JupyterLab with: jupyter lab"
