import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('renderer', ROOT/'scripts/render_resume.py')
renderer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(renderer)


class RenderTests(unittest.TestCase):
    def test_real_content_fills_all_slots_deterministically(self):
        source = (ROOT/'content/resume.md').read_text()
        template = (ROOT/'templates/index.html').read_text()
        output = renderer.render(source, template)
        self.assertNotIn('{{ ', output)
        self.assertEqual(output, renderer.render(source, template))
        self.assertIn('Mondelēz International', output)
        self.assertIn('assets/maria-tzanidaki-resume.pdf', output)
        changed = source.replace('Mondelēz International', 'Example & Company')
        self.assertIn('Example &amp; Company', renderer.render(changed, template))

    def test_unicode_and_safe_inline_formatting(self):
        source = '# About\n## Summary\nΕλληνικά & **cloud** *engineer* `AWS` <script>alert(1)</script>'
        result = renderer.render(source, '<p>{{ about.summary }}</p>')
        self.assertIn('Ελληνικά &amp; <strong>cloud</strong>', result)
        self.assertIn('&lt;script&gt;', result)
        self.assertNotIn('<script>', result)

    def test_invalid_fields_do_not_silently_drop_content(self):
        for source in ['# A\n## B\n', '# A\n## B\nx\n## B\ny', '# A\n## C\nx']:
            with self.subTest(source=source), self.assertRaises(ValueError):
                renderer.render(source, '{{ a.b }}')

    def test_links_and_block_content_are_rejected(self):
        for value in ['[click](javascript:alert)', 'x\n\ny', '- one\n- two']:
            with self.subTest(value=value), self.assertRaises(ValueError):
                renderer.inline(value)


if __name__ == '__main__':
    unittest.main()
