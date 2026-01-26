# Maria Tzanidaki - Resume Website

A personal resume website with automatic PDF generation.

## Quick Start

1. **Install dependencies**:
   ```bash
   ./scripts/install-dependencies.sh
   pre-commit install
   ```

2. **Customize your resume**:
   - Edit `index.html` with your information
   - Replace `images/photo.png` with your photo

3. **Test locally**:
   ```bash
   open index.html
   ```

4. **Deploy**:
   ```bash
   git add .
   git commit -m "Update resume"
   git push origin main
   ```

The PDF is automatically generated on commit and saved to `assets/maria-tzanidaki-resume.pdf`.

## GitHub Pages Setup

1. Go to your repository Settings > Pages
2. Select "Deploy from a branch"
3. Choose "main" branch and "/ (root)" folder
4. Your site will be at `https://yourusername.github.io/resume/`

## Features

- Responsive design with Tailwind CSS
- Dark theme with modern UI
- Automatic PDF generation via pre-commit hook
- Mobile-friendly layout

## Customization

Edit `index.html` sections:
- **Header**: Name and title
- **About**: Professional summary
- **Contact**: Email, phone, LinkedIn
- **Skills**: Technical competencies
- **Experience**: Work history
- **Projects**: Notable projects
- **Education**: Degrees and certifications

## PDF Generation

The pre-commit hook automatically generates a PDF when you commit changes to `index.html` or CSS files.

**Dependencies** (installed via `install-dependencies.sh`):
- pandoc
- weasyprint
- pdftk-java
- pre-commit

**Manual generation**:
```bash
./scripts/generate-pdf.sh
```

## Troubleshooting

- **PDF generation fails**: Run `./scripts/install-dependencies.sh` to verify all dependencies are installed
- **Changes not appearing**: Check the Actions tab for deployment errors
- **Styling issues**: Verify Tailwind CSS classes and HTML syntax

## License

Free to use as a template for your own resume.
