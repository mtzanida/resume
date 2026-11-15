"""Render named Markdown fields into the existing resume layout."""
import argparse
import html
from pathlib import Path
import re
import sys

import markdown

ROOT = Path(__file__).resolve().parents[1]
TOKEN = re.compile(r'\{\{ ([a-z0-9.-]+) \}\}')


def parse_content(source):
    fields = {}
    section = key = None
    lines = []

    def finish():
        if key is not None:
            value = '\n'.join(lines).strip()
            if not value:
                raise ValueError(f'Empty field: {key}')
            fields[key] = value

    for line in source.splitlines():
        if line.startswith('# '):
            finish()
            section = line[2:].strip().lower()
            key, lines = None, []
        elif line.startswith('## '):
            finish()
            if not section:
                raise ValueError('Fields must be inside a # section')
            key = section + '.' + line[3:].strip().lower().replace(' ', '-')
            if key in fields:
                raise ValueError(f'Duplicate field: {key}')
            lines = []
        elif key:
            lines.append(line)
        elif line.strip():
            raise ValueError('Content must be inside a ## field')
    finish()
    return fields


def inline(value):
    # Escape HTML before Markdown conversion. Links stay in the template so text
    # editing cannot inject an executable URL or nested anchors.
    escaped = html.escape(value, quote=False)
    result = markdown.markdown(escaped)
    if not re.fullmatch(r'<p>.*</p>', result, flags=re.S):
        raise ValueError('Each field must contain one paragraph (inline formatting only)')
    result = result[3:-4]
    tags = re.findall(r'</?([a-zA-Z0-9]+)\b[^>]*>', result)
    if any(tag not in {'strong', 'em', 'code'} for tag in tags):
        raise ValueError('Only plain text, bold, italic and inline code are supported')
    return result


def render(source, template):
    fields = parse_content(source)
    required = set(TOKEN.findall(template))
    if set(fields) != required:
        raise ValueError(f'Field mismatch: missing={sorted(required-set(fields))}, unknown={sorted(set(fields)-required)}')
    rendered = {key: inline(value) for key, value in fields.items()}
    return TOKEN.sub(lambda match: rendered[match[1]], template)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='Fail if index.html is stale')
    args = parser.parse_args()
    try:
        output = render((ROOT/'content/resume.md').read_text(), (ROOT/'templates/index.html').read_text())
    except ValueError as exc:
        parser.error(str(exc))
    target = ROOT/'index.html'
    if args.check:
        if target.read_text() != output:
            print('index.html is stale; run scripts/md-to-html.sh', file=sys.stderr)
            return 1
    else:
        target.write_text(output)
    return 0


if __name__ == '__main__':
    sys.exit(main())
