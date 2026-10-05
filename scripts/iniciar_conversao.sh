#!/usr/bin/env bash
set -euo pipefail
harpa_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
harpa_python="${HARPA_PYTHON:-/home/djames/Documents/ClaveSol/site/clavesol/.venv/bin/python}"
harpa_state="/home/djames/Documents/ClaveSol/lab/harpa-crista-conversao"
"$harpa_python" -c 'import mido, markdown'
mkdir -p "$harpa_state"
nohup "$harpa_python" -u "$harpa_root/scripts/converter_harpa_crista.py" >> "$harpa_state/execucao.log" 2>&1 < /dev/null &
harpa_pid=$!
printf '%s\n' "$harpa_pid" > "$harpa_state/process.pid"
printf 'Conversão iniciada (PID %s).\n' "$harpa_pid"
printf 'watch -n 5 cat %s/resumo.txt\n' "$harpa_state"
