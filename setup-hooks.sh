#!/bin/bash

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy the pre-commit hook to the git hooks directory
cp .github/hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo "Pre-commit hook installed successfully."
echo "Note: You'll need pandoc and weasyprint installed for the PDF generation."
echo "Install them with: brew install pandoc weasyprint"
echo ""
echo "IMPORTANT: This hook expects the styling repository to be available at '../styling'"
echo "If your styling repository is located elsewhere, please update the STYLING_REPO_PATH"
echo "variable in the pre-commit hook."
