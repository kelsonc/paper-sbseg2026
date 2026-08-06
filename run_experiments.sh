#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTEBOOK_DIR="${ROOT_DIR}/notebooks"
OUTPUT_DIR="${ROOT_DIR}/results/executed_notebooks"

usage() {
    echo "Usage: $0 7 8 9"
    echo "       $0 all"
    echo "       $0 <experiment_number> [<experiment_number> ...]"
}

if ! command -v jupyter >/dev/null 2>&1; then
    echo "Error: jupyter was not found. Activate the environment created by setup_env.sh." >&2
    exit 1
fi

if [[ $# -eq 0 ]]; then
    usage
    exit 2
fi

if [[ "$1" == "all" ]]; then
    if [[ $# -ne 1 ]]; then
        echo "Error: 'all' cannot be combined with experiment numbers." >&2
        exit 2
    fi
    experiments=(1 2 3 4 5 6 7 8 9)
else
    experiments=("$@")
fi

mkdir -p "${OUTPUT_DIR}"

for experiment in "${experiments[@]}"; do
    if [[ ! "${experiment}" =~ ^[1-9]$ ]]; then
        echo "Error: invalid experiment '${experiment}'. Use a number from 1 to 9 or 'all'." >&2
        exit 2
    fi

    notebook="${NOTEBOOK_DIR}/notebook_${experiment}.ipynb"
    if [[ ! -f "${notebook}" ]]; then
        echo "Error: notebook not found: ${notebook}" >&2
        exit 1
    fi

    echo "Running Experiment ${experiment}: ${notebook}"
    jupyter nbconvert \
        --to notebook \
        --execute "${notebook}" \
        --output "notebook_${experiment}_executed.ipynb" \
        --output-dir "${OUTPUT_DIR}" \
        --ExecutePreprocessor.timeout=-1
done

echo "Completed. Executed notebooks are available in: ${OUTPUT_DIR}"
