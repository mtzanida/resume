# Assets Directory

This directory contains downloadable assets for the resume website, such as the PDF version of the resume.

## Generating PDF from HTML using Pandoc

You can generate a PDF version of your resume directly from the HTML file using Pandoc. This ensures that your PDF resume always matches your website content.

### Prerequisites

1. Install Pandoc: https://pandoc.org/installing.html
2. Install a PDF engine (like wkhtmltopdf): https://wkhtmltopdf.org/downloads.html

### Generate PDF

Run the following command from the root directory of the project:

```bash
pandoc index.html -o assets/maria-tzanidaki-resume.pdf
```

### Advanced Options

For better PDF formatting, you can use additional options:

```bash
pandoc index.html -o assets/maria-tzanidaki-resume.pdf --pdf-engine=wkhtmltopdf --css=pdf-styles.css
```

You can create a `pdf-styles.css` file with custom styles for the PDF output.

### Automating PDF Generation

You can add this command to your workflow to automatically generate a new PDF whenever you update your HTML resume:

```bash
# Update HTML file
vim index.html

# Generate updated PDF
pandoc index.html -o assets/maria-tzanidaki-resume.pdf

# Commit and push changes
git add .
git commit -m "Update resume content and PDF"
git push origin main
```

This ensures your downloadable PDF is always in sync with your website content.
