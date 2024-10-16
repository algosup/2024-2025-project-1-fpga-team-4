#!/bin/bash

# Function to check if a program is installed
check_program() {
    command -v $1 &>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "$1 is not installed. Installing..."
        install_$1
    else
        echo "$1 is already installed."
    fi
}

# Function to install Python
install_python() {
    echo "Installing Python 3.10 or higher..."
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install -y python3.10 python3-pip
        elif command -v yum &>/dev/null; then
            sudo yum install -y python3
        else
            echo "Unsupported package manager. Please install Python manually."
            exit 1
        fi
    else
        echo "Unsupported OS. Please install Python manually."
        exit 1
    fi
}

# Function to install Git
install_git() {
    echo "Installing Git..."
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        if command -v apt &>/dev/null; then
            sudo apt install -y git
        elif command -v yum &>/dev/null; then
            sudo yum install -y git
        else
            echo "Unsupported package manager. Please install Git manually."
            exit 1
        fi
    fi
}

# Function to install Apio
install_apio() {
    echo "Installing Apio..."
    pip3 install --user -U apio
    if [[ $? -ne 0 ]]; then
        echo "Failed to install Apio. Make sure pip is working correctly."
        exit 1
    fi
}

# Check for Python
check_program python3

# Check for Git
check_program git

# Check for pip
command -v pip3 &>/dev/null
if [[ $? -ne 0 ]]; then
    echo "pip is not installed. Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    if [[ $? -ne 0 ]]; then
        echo "Failed to install pip. Please try manually."
        exit 1
    fi
    rm get-pip.py
fi

# Upgrade pip to the latest version
echo "Upgrading pip..."
python3 -m pip install --upgrade pip
if [[ $? -ne 0 ]]; then
    echo "Failed to upgrade pip. Please try manually."
    exit 1
fi

# Check for Apio
check_program apio

# Clone the GitHub repository if not already cloned
REPO_URL="https://github.com/algosup/2024-2025-project-1-fpga-team-4"
REPO_DIR="2024-2025-project-1-fpga-team-4"

if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning the GitHub repository..."
    git clone --branch MinimumRequirement "$REPO_URL"
    if [[ $? -ne 0 ]]; then
        echo "Failed to clone the repository."
        exit 1
    fi
else
    echo "Repository already cloned."
fi

# Navigate to the project directory
cd "$REPO_DIR/src" || { echo "Failed to navigate to the project directory."; exit 1; }

# Check if apio.ini exists; if not, initialize it
if [ ! -f "apio.ini" ]; then
    echo "Creating apio.ini file with the specified board."
    apio init -b go-board # Replace "go-board" with the actual board name if different
    if [[ $? -ne 0 ]]; then
        echo "Failed to create apio.ini. Please check the board name and try again."
        exit 1
    fi
fi

# Upload the code to the Go Board
echo "Uploading code to the Go Board..."
apio upload
if [[ $? -ne 0 ]]; then
    echo "Upload failed. Make sure the FPGA board is connected and try again."
    exit 1
fi

echo "Upload completed successfully. Please connect the VGA cable and power the board."
