"""Render the generated HTML and add the profile photo to the first page."""
from pathlib import Path
import subprocess
import tempfile

from pypdf import PdfReader, PdfWriter
from weasyprint import HTML

ROOT = Path(__file__).resolve().parents[1]


def main():
    target = ROOT/'assets/maria-tzanidaki-resume.pdf'
    with tempfile.TemporaryDirectory(prefix='resume-pdf-') as directory:
        work = Path(directory)
        css = work/'print.css'
        css.write_text(
            '@import url("' + (ROOT/'styling/pdf-styles-single-page.css').as_uri() + '");\n'
            'img[src*="photo"], .download-btn, [download], a[href$=".pdf"] '
            '{ display: none !important; }\n'
        )
        subprocess.run([
            'pandoc', str(ROOT/'index.html'), '-o', str(work/'content.pdf'),
            '--pdf-engine=weasyprint', '--css='+str(css),
            '--resource-path='+str(ROOT), '--embed-resources',
        ], cwd=ROOT, check=True)
        photo = '''<html><head><style>
        @page { size: letter; margin: 0; }
        body { margin: 0; }
        img { position: absolute; top: 0; right: 0; width: 80px; height: auto; }
        </style></head><body><img src="images/photo.png"></body></html>'''
        HTML(string=photo, base_url=str(ROOT)+'/').write_pdf(work/'photo.pdf')
        content = PdfReader(work/'content.pdf')
        layer = PdfReader(work/'photo.pdf')
        if not content.pages:
            raise RuntimeError('Resume PDF contains no pages')
        writer = PdfWriter()
        for index, page in enumerate(content.pages):
            if index == 0:
                page.merge_page(layer.pages[0], over=False)
            writer.add_page(page)
        target.parent.mkdir(exist_ok=True)
        temporary = work/'resume.pdf'
        writer.write(temporary)
        # Only replace the existing PDF after the entire build succeeds.
        target.write_bytes(temporary.read_bytes())


if __name__ == '__main__':
    main()
