#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bash scripts/md-to-html.sh
python3 scripts/render_pdf.py
git add assets/maria-tzanidaki-resume.pdf
