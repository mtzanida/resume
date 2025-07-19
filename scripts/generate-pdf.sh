#!/bin/bash

echo "Starting PDF generation script..."

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

# Check if styling repository is available
STYLING_REPO_PATH="../styling"  # Adjust this path to where your styling repository is located
if [ ! -d "$STYLING_REPO_PATH" ]; then
  echo "Warning: Styling repository not found at $STYLING_REPO_PATH"
  echo "PDF generation might not include all styling elements."
else
  echo "Using styling files from: $STYLING_REPO_PATH"
  # Copy necessary styling files if needed
  # cp $STYLING_REPO_PATH/pdf-styles.css ./pdf-styles.css
fi

# Make sure assets directory exists
mkdir -p assets

echo "Generating PDF..."
# Generate the PDF with verbose output to help debug any issues
pandoc index.html -o assets/maria-tzanidaki-resume.pdf --pdf-engine=weasyprint --css=pdf-styles.css -v

if [ $? -ne 0 ]; then
  echo "Error: Failed to generate PDF."
  exit 1
fi

# Add the generated PDF to the commit
git add assets/maria-tzanidaki-resume.pdf

echo "PDF successfully generated and added to commit."
exit 0
