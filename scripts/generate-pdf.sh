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

# Create a temporary CSS file to completely hide any existing photos
TEMP_CSS="temp_hide_photos.css"

cat > $TEMP_CSS << EOF
/* Import the original styles */
@import url("styling/pdf-styles-single-page.css");

/* Hide any existing photos */
img[src*="photo"] {
  display: none !important;
}

/* Hide any download buttons or text */
.download-btn, [download], a[href$=".pdf"] {
  display: none !important;
}
EOF

echo "Generating content PDF with styling (with photos hidden)..."
# Generate the main PDF with styling and photos hidden
pandoc index.html -o assets/content.pdf --pdf-engine=weasyprint --css=$TEMP_CSS --resource-path=.:./images:./styling --embed-resources 2> /dev/null

# Create a simple HTML file with just the photo
PHOTO_HTML="temp_photo.html"

cat > $PHOTO_HTML << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Photo</title>
  <style>
    @page {
      margin: 0;
      padding: 0;
    }
    body {
      margin: 0;
      padding: 0;
    }
    .photo-container {
      position: absolute;
      top: 0;
      right: 0;
      margin: 0;
      padding: 0;
    }
    .photo {
      width: 80px;
      height: auto;
      margin: 0;
      padding: 0;
      display: block;
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

echo "Generating photo layer..."
# Generate a transparent PDF with just the photo
weasyprint $PHOTO_HTML assets/photo_layer.pdf

echo "Combining PDFs..."
# Use pdftk with the background option instead of stamp
if command -v pdftk &> /dev/null; then
  # Use pdftk to overlay the photo onto the first page
  pdftk assets/content.pdf background assets/photo_layer.pdf output assets/maria-tzanidaki-resume.pdf
elif command -v gs &> /dev/null; then
  # Use ghostscript as an alternative
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=assets/maria-tzanidaki-resume.pdf assets/content.pdf assets/photo_layer.pdf
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
rm $PHOTO_HTML $TEMP_CSS assets/photo_layer.pdf assets/content.pdf
# Remove any warning logs
rm -f weasyprint-warnings.log

echo "PDF successfully generated and added to commit."
exit 0
