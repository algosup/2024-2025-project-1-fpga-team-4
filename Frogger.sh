#!/bin/bash

# Check if Apio is installed
if command -v apio &> /dev/null; then
    echo "Apio is already installed."
else
    # Check if Python 3.10 or higher is installed
    if ! command -v python3 &> /dev/null; then
        echo "Python is not installed. Please install Python 3.10 or higher."
        exit 1
    fi

    PYTHON_VERSION=$(python3 --version | cut -d " " -f 2)
    if [[ "$PYTHON_VERSION" < "3.10" ]]; then
        echo "Python version is less than 3.10. Please install Python 3.10 or higher."
        exit 1
    fi

    # Install Apio
    echo "Installing Apio..."
    pip3 install -U apio
    if [ $? -ne 0 ]; then
        echo "Failed to install Apio. Make sure you have pip installed and try again."
        exit 1
    fi
fi

# Clone the GitHub repository if not already cloned
REPO_URL="https://github.com/algosup/2024-2025-project-1-fpga-team-4"
REPO_DIR="2024-2025-project-1-fpga-team-4"

if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning the GitHub repository..."
    git clone --branch MinimumRequirement "$REPO_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository."
        exit 1
    fi
else
    echo "Repository already cloned."
fi

# Navigate to the project directory
cd "$REPO_DIR" || { echo "Failed to navigate to the project directory."; exit 1; }
cd src

# Check if apio.ini exists; if not, initialize it
if [ ! -f "apio.ini" ]; then
    echo "Creating apio.ini file with the specified board."
    apio init -b "go-board"  # Replace <boardname> with the actual board name, e.g., go_board
    if [ $? -ne 0 ]; then
        echo "Failed to create apio.ini. Please check the board name and try again."
        exit 1
    fi
fi

# Upload the code to the Go Board
echo "Uploading code to the Go Board..."
apio upload
if [ $? -ne 0 ]; then
    echo "Upload failed. Make sure the FPGA board is connected and try again."
    exit 1
fi

echo "Upload completed successfully. Please connect the VGA cable and power the board."
