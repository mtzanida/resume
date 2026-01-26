#!/bin/bash

set -e

echo "=========================================="
echo "Installing Resume PDF Generator Dependencies"
echo "=========================================="
echo ""

# Detect OS
OS="$(uname -s)"

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Install Homebrew dependencies (macOS/Linux)
if [[ "$OS" == "Darwin" ]] || [[ "$OS" == "Linux" ]]; then
  echo "Detected: $OS"
  
  # Check if Homebrew is installed
  if ! command_exists brew; then
    echo "Error: Homebrew is not installed."
    echo "Please install Homebrew first: https://brew.sh"
    exit 1
  fi
  
  echo ""
  echo "Installing system dependencies via Homebrew..."
  
  # Install pandoc
  if ! command_exists pandoc; then
    echo "Installing pandoc..."
    brew install pandoc
  else
    echo "✓ pandoc already installed"
  fi
  
  # Install pdftk-java
  if ! command_exists pdftk; then
    echo "Installing pdftk-java..."
    brew install pdftk-java
  else
    echo "✓ pdftk already installed"
  fi
  
else
  echo "Unsupported OS: $OS"
  echo "Please install dependencies manually:"
  echo "  - pandoc"
  echo "  - weasyprint"
  echo "  - pdftk"
  exit 1
fi

# Install Python dependencies
echo ""
echo "Installing Python dependencies..."

# Check if pip is available
if ! command_exists pip3 && ! command_exists pip; then
  echo "Error: pip is not installed."
  echo "Please install Python 3 and pip first."
  exit 1
fi

# Use pip3 if available, otherwise pip
PIP_CMD="pip3"
if ! command_exists pip3; then
  PIP_CMD="pip"
fi

# Install Python packages
echo "Using $PIP_CMD to install packages..."
if [ -f "requirements.txt" ]; then
  $PIP_CMD install -r requirements.txt
else
  echo "Error: requirements.txt not found"
  exit 1
fi

# Verify installations
echo ""
echo "=========================================="
echo "Verifying installations..."
echo "=========================================="

MISSING_DEPS=0

if command_exists pandoc; then
  echo "✓ pandoc: $(pandoc --version | head -n1)"
else
  echo "✗ pandoc: NOT FOUND"
  MISSING_DEPS=1
fi

if python3 -c "import weasyprint" 2>/dev/null; then
  echo "✓ weasyprint: $(python3 -c 'import weasyprint; print(weasyprint.__version__)')"
else
  echo "✗ weasyprint: NOT FOUND"
  MISSING_DEPS=1
fi

if command_exists pdftk; then
  echo "✓ pdftk: installed"
else
  echo "✗ pdftk: NOT FOUND"
  MISSING_DEPS=1
fi

if command_exists pre-commit; then
  echo "✓ pre-commit: $(pre-commit --version)"
elif python3 -c "import pre_commit" 2>/dev/null; then
  echo "✓ pre-commit: installed via pip"
else
  echo "✗ pre-commit: NOT FOUND"
  MISSING_DEPS=1
fi

echo ""

if [ $MISSING_DEPS -eq 0 ]; then
  echo "=========================================="
  echo "✓ All dependencies installed successfully!"
  echo "=========================================="
  echo ""
  echo "Next steps:"
  echo "  1. Run: pre-commit install"
  echo "  2. Make changes to index.html"
  echo "  3. Commit your changes - PDF will be generated automatically"
  exit 0
else
  echo "=========================================="
  echo "✗ Some dependencies are missing"
  echo "=========================================="
  echo "Please install them manually and try again."
  exit 1
fi
