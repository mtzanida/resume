#!/bin/bash

echo "Starting PDF generation script..."
echo "Current working directory: $(pwd)"

# Always generate the PDF regardless of which files changed
# This ensures we don't miss any changes and the PDF is always up-to-date

# Check if pandoc and weasyprint are installed
if ! command -v pandoc &> /dev/null; then
  echo "Error: pandoc is not installed."
  echo "Please install it with: brew install pandoc"
  exit 1
fi

if ! command -v weasyprint &> /dev/null; then
  echo "Error: weasyprint is not installed."
  echo "Please install it with: brew install weasyprint"
  exit 1
fi

# Make sure assets directory exists
mkdir -p assets

# Create a simple HTML file with just the photo
TEMP_HTML="temp_resume_with_photo.html"

cat > $TEMP_HTML << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Maria Tzanidaki - Resume</title>
  <style>
    .photo-container {
      text-align: center;
      margin-bottom: 20px;
    }
    .photo {
      max-width: 150px;
      border-radius: 50%;
    }
  </style>
</head>
<body>
  <div class="photo-container">
    <img class="photo" src="images/photo.png" alt="Maria Tzanidaki">
  </div>
</body>
</html>
EOF

echo "Generating PDF with photo..."
# First generate a PDF with just the photo
weasyprint $TEMP_HTML assets/photo.pdf

echo "Generating main resume PDF..."
# Then generate the main resume PDF
pandoc index.html -o assets/main_resume.pdf --pdf-engine=weasyprint --css=styling/pdf-styles-single-page.css --resource-path=.:./images:./styling --embed-resources 2> weasyprint-warnings.log

echo "Combining PDFs..."
# Now combine the PDFs using pdftk if available
if command -v pdftk &> /dev/null; then
  pdftk assets/photo.pdf assets/main_resume.pdf cat output assets/maria-tzanidaki-resume.pdf
elif command -v gs &> /dev/null; then
  # Alternative using ghostscript
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=assets/maria-tzanidaki-resume.pdf assets/photo.pdf assets/main_resume.pdf
else
  echo "Error: Neither pdftk nor ghostscript is installed. Cannot combine PDFs."
  echo "Please install pdftk or ghostscript."
  exit 1
fi

# Check if the final PDF was created and has content
if [ ! -f "assets/maria-tzanidaki-resume.pdf" ]; then
  echo "Error: Final PDF file was not created."
  exit 1
fi

# Check if the PDF has content
if [ ! -s "assets/maria-tzanidaki-resume.pdf" ]; then
  echo "Error: Final PDF file was created but is empty."
  exit 1
fi

echo "PDF file details:"
ls -la assets/maria-tzanidaki-resume.pdf

# Add the generated PDF to the commit
git add assets/maria-tzanidaki-resume.pdf

# Clean up temporary files
rm $TEMP_HTML
rm assets/photo.pdf
rm assets/main_resume.pdf

echo "PDF successfully generated and added to commit."
exit 0


