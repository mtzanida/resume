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

# Remove any existing PDF to ensure we don't get confused by an old file
if [ -f "assets/maria-tzanidaki-resume.pdf" ]; then
  echo "Removing existing PDF file..."
  rm assets/maria-tzanidaki-resume.pdf
fi

echo "Generating PDF..."
# Use the simplified command that you confirmed works
pandoc index.html -o assets/maria-tzanidaki-resume.pdf --pdf-engine=weasyprint

# Check if the PDF was actually created and has content
if [ ! -f "assets/maria-tzanidaki-resume.pdf" ]; then
  echo "Error: PDF file was not created."
  exit 1
fi

# Check if the PDF has content
if [ ! -s "assets/maria-tzanidaki-resume.pdf" ]; then
  echo "Error: PDF file was created but is empty."
  exit 1
fi

echo "PDF file details:"
ls -la assets/maria-tzanidaki-resume.pdf

# Add the generated PDF to the commit
git add assets/maria-tzanidaki-resume.pdf

echo "PDF successfully generated and added to commit."
exit 0