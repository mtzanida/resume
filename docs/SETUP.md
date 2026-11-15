# Setup and Customization Guide

[Back to project overview](../README.md)

## Preview the website

The website is static HTML and does not require a build step. From the repository
root, open `index.html` in a browser, or serve it locally:

```bash
python3 -m http.server 8000
```

Open http://localhost:8000. External styles and icons require internet access.

## Customize the resume

Update the sections in `index.html`:

| Section | Content |
| --- | --- |
| Header and About | Name, professional title and summary |
| Contact | Email, phone and professional links |
| Skills | Technical competencies |
| Experience | Work history |
| Projects | Selected projects |
| Education | Degrees and certifications |

Replace `images/photo.png` with your photo. Review the page title, metadata, image
alternative text and PDF download link when adapting the project for another person.
The included `initial-draft/index.tsx` is not built into the published HTML site.

## Install PDF tooling

The provided installer supports macOS and Linux with Homebrew already installed,
plus Python 3 and pip. It installs Pandoc and pdftk-java through Homebrew and Python
packages from `requirements.txt`.

Run from the repository root:

```bash
./scripts/install-dependencies.sh
pre-commit install
```

If managing Python dependencies in a virtual environment, activate it before
running the installer and keep it active when using the hooks. WeasyPrint may
also require native libraries for your platform; inspect its error output if
installation or rendering fails.

## Generate the PDF

Run from the repository root:

```bash
./scripts/generate-pdf.sh
```

The script uses Pandoc and WeasyPrint to render the resume with
`styling/pdf-styles-single-page.css`, creates a separate photo layer, and uses
pdftk to add the photo to the first page. The output is:

`assets/maria-tzanidaki-resume.pdf`

**The script also stages the generated PDF with `git add`, including when run
manually.** Inspect the PDF and staged changes before committing. If changing the
output filename, update both the script and the website's download link.

The stylesheet name does not guarantee a single-page PDF. Check page count,
clipping, typography, links and photo placement after changing resume content.

## Automatic generation on commit

After `pre-commit install`, the PDF hook runs when staged files match
`index.html` or `styling/pdf-styles-single-page.css`. It does not automatically
run for every CSS file or for photo-only changes. Regenerate manually after
changing the photo or other inputs not covered by the hook.

Other hooks fix whitespace, check YAML and file size, and format HTML/CSS/JavaScript.
If a hook modifies files, review and stage them, then retry the commit.
If formatting changed `index.html` after PDF generation, regenerate and review
the PDF again so both versions match.

## Publish with GitHub Pages

1. In repository **Settings → Pages**, select **Deploy from a branch**.
2. Select the `main` branch and `/ (root)` folder, then save.
3. Commit the reviewed website changes and generated PDF to your working branch.
4. Merge through your normal review process into the configured publishing branch.
5. Check the Pages deployment status and the URL reported in repository settings.

For this repository, the expected project-site URL is
https://mtzanida.github.io/resume/ when default GitHub Pages publishing is enabled.
Confirm the actual URL in settings if a custom domain is configured.

There is no checked-in GitHub Actions workflow for PDF generation. Publishing
serves the committed PDF; it does not regenerate it.

## Troubleshooting

- **Missing PDF tools:** run the installer or check that `pandoc`, `weasyprint`,
  `pdftk` and `pre-commit` are on your PATH.
- **PDF rendering fails:** inspect the command output and native WeasyPrint
  dependencies. The generator suppresses Pandoc stderr; rerun the relevant
  command without that redirection if you need its diagnostics.
- **PDF appears outdated:** regenerate manually, inspect it and commit the result.
  Photo-only changes do not trigger the configured PDF hook.
- **Commit stops after formatting:** review and stage hook changes, regenerate
  the PDF if the source changed, then retry.
- **Published changes do not appear:** confirm the Pages branch/folder, deployment
  status and whether both the HTML and PDF were committed.
- **Website styling is missing:** check external stylesheet/CDN requests and HTML
  syntax. Browser styles and PDF styles are separate.
