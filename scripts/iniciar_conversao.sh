#!/usr/bin/env bash
set -euo pipefail
harpa_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
harpa_python="${HARPA_PYTHON:-/home/djames/Documents/ClaveSol/site/clavesol/.venv/bin/python}"
harpa_state="/home/djames/Documents/ClaveSol/lab/harpa-crista-conversao"
"$harpa_python" -c 'import mido, markdown'
mkdir -p "$harpa_state"
"$harpa_python" - "$harpa_root" "$harpa_state" <<'LAUNCH'
import os
from pathlib import Path
import subprocess
import sys
import time

root, state = map(Path, sys.argv[1:])
started = time.time()
with (state/'execucao.log').open('a') as log:
    process = subprocess.Popen(
        [sys.executable, '-u', str(root/'scripts/converter_harpa_crista.py')],
        cwd=root, stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
        start_new_session=True,
    )
(state/'process.pid').write_text(str(process.pid)+'\n')
for _ in range(50):
    if process.poll() is not None:
        raise SystemExit('A conversão não iniciou. Consulte execucao.log.')
    summary = state/'resumo.txt'
    if summary.exists() and summary.stat().st_mtime >= started:
        print(f'Conversão iniciada e resumo criado (PID {process.pid}).')
        print(f'watch -n 5 cat {summary}')
        break
    time.sleep(0.1)
else:
    raise SystemExit('Processo lançado, mas o resumo ainda não foi confirmado. Consulte execucao.log.')
LAUNCH
