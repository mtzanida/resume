# Resume Content and Publishing Guide

[Back to project overview](../README.md)

## Edit content in Markdown

Edit `content/resume.md` rather than generated `index.html`. The file has named
sections (Profile, About, Contact, Skills, Experience, Education, Projects, Footer)
and named fields under `##` headings. Keep the headings intact: they map to slots
in `templates/index.html`. Change the paragraphs underneath them.

Example:

```markdown
# About

## Section title 1

Summary

## Paragraph 1

Cloud Engineer working with **AWS**, Terraform and automation.
```

Fields support Unicode, ampersands, plain text, **bold**, *italic* and inline code.
Each field must be one paragraph; lists, links and raw HTML are not supported as
formatting. HTML text is escaped. The existing cards, achievement bullets and
badges are supplied by the template. To add a new card/achievement, add a matching
named field and template slot; unknown, missing, empty or duplicate fields fail
instead of silently losing resume content. Contact link destinations and metadata
remain in the template, so update those there when changing identity or URLs.

## Install dependencies

Use Python 3.11+ and Pandoc, plus WeasyPrint's native libraries for your platform.
The provided installer uses Homebrew on macOS/Linux; activate your preferred
Python virtual environment before running it:

```bash
python3 -m venv .venv
source .venv/bin/activate
./scripts/install-dependencies.sh
pre-commit install
```

Python dependencies are in `requirements.txt`. PDF composition uses pypdf;
pdftk/Java are no longer required.

## Generate and preview

From the repository root:

```bash
bash scripts/md-to-html.sh
python3 -m http.server 8000
```

Open http://localhost:8000. The HTML retains the existing styling and uses external
Tailwind and icon CDNs. Change presentation in `templates/index.html`, not the
generated file. The initial TSX draft is not part of this build.

Generate the matching downloadable PDF:

```bash
bash scripts/generate-pdf.sh
```

This first regenerates HTML, then renders it with Pandoc/WeasyPrint and the existing
print stylesheet. pypdf adds the photo to the first page. The output is
`assets/maria-tzanidaki-resume.pdf`; the shell script stages that PDF with `git add`.
Review all pages for clipping and photo placement before committing. A failed build
does not replace the existing PDF.

## Local hooks and checks

The HTML hook runs before PDF generation for Markdown/template/converter changes.
The PDF hook also covers the photo, PDF stylesheet and generation scripts. Review
and stage generated `index.html` and hook changes, then retry the commit if
pre-commit reports modified files. If Prettier changes a source/template, rerun the
build before committing.

```bash
python -m unittest discover -s tests -v
bash scripts/md-to-html.sh --check
```

## Automatic build and deployment

`.github/workflows/resume.yml` runs tests and builds HTML/PDF for relevant PRs.
PRs do not commit or deploy. On main, or manual dispatch from main, it commits
changed generated files and explicitly deploys a Pages artifact. It does not rely
on a bot commit triggering another workflow. A failed build prevents deployment.

One-time repository configuration:

1. In Settings → Pages, set Source to **GitHub Actions** (replace branch publishing).
2. Allow the workflow to write repository contents and deploy to the `github-pages`
   environment. If main is protected, its rules must permit the generated-output
   commit; otherwise that step fails without deploying. Review those settings
   yourself; this PR does not modify repository permissions or rules.
3. Merge reviewed source changes into main and check the Build resume workflow.

Only `index.html`, images and the PDF are included in the Pages artifact. Confirm
the live URL in repository settings; the expected default project URL is
https://mtzanida.github.io/resume/.

## Troubleshooting

- **Field mismatch:** restore heading names or add the matching template slot.
- **Unsupported formatting:** use one paragraph with inline bold, italic or code.
- **Stale HTML:** run the converter and stage `index.html`.
- **Missing tools:** check Python requirements, Pandoc and native WeasyPrint libraries.
- **PDF failure:** inspect the visible Pandoc/WeasyPrint error; the old PDF is preserved.
- **Workflow cannot commit:** inspect write permissions, branch rules and concurrent
  changes. Pushes reject a stale branch instead of overwriting changes.
- **Pages deployment fails:** confirm GitHub Actions is selected as the Pages source
  and the github-pages environment allows main.
