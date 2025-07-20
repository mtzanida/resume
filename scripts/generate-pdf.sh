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

echo "Extracting first page from content PDF..."
# Extract just the first page from the content PDF
if command -v pdftk &> /dev/null; then
  pdftk assets/content.pdf cat 1 output assets/first_page.pdf
  pdftk assets/content.pdf cat 2-end output assets/rest_pages.pdf 2>/dev/null || touch assets/rest_pages.pdf
else
  echo "Error: pdftk is required for this operation."
  exit 1
fi

echo "Adding photo to first page only..."
# Add the photo to just the first page
pdftk assets/first_page.pdf background assets/photo_layer.pdf output assets/first_page_with_photo.pdf

echo "Combining all pages..."
# Combine the first page with photo and the rest of the pages
if [ -s assets/rest_pages.pdf ]; then
  # If there are additional pages
  pdftk assets/first_page_with_photo.pdf assets/rest_pages.pdf cat output assets/maria-tzanidaki-resume.pdf
else
  # If there's only one page
  cp assets/first_page_with_photo.pdf assets/maria-tzanidaki-resume.pdf
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
rm $PHOTO_HTML $TEMP_CSS assets/photo_layer.pdf assets/content.pdf assets/first_page.pdf assets/first_page_with_photo.pdf
rm -f assets/rest_pages.pdf
# Remove any warning logs
rm -f weasyprint-warnings.log

echo "PDF successfully generated and added to commit."
exit 0