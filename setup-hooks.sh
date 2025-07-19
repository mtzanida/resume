#!/bin/bash

# Copy the pre-commit hook to the git hooks directory
cp .git/hooks/pre-commit .github/hooks/pre-commit
chmod +x .github/hooks/pre-commit

echo "Pre-commit hook installed successfully."
echo "Note: You'll need pandoc and weasyprint installed for the PDF generation."
echo "Install them with: brew install pandoc weasyprint"
