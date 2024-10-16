#!/bin/bash

# Function to check if Python is installed
check_python_installed() {
    echo "Checking if Python is installed..."
    if command -v python3 &> /dev/null; then
        echo "Python is installed."
    else
        echo "Python is not installed. Installing Python..."
        install_python
    fi
}

# Function to accept the Xcode license
accept_xcode_license() {
    echo "Checking for Xcode license..."
    if /usr/bin/xcodebuild -license status &> /dev/null; then
        echo "Xcode license has already been accepted."
    else
        echo "You have not agreed to the Xcode license. Accepting the Xcode license..."
        sudo xcodebuild -license accept
        if [ $? -ne 0 ]; then
            echo "Failed to accept the Xcode license. Please run 'sudo xcodebuild -license' manually and accept the terms."
            exit 1
        fi
    fi
}

# Check if running on macOS and accept the Xcode license if needed
if [[ "$OSTYPE" == "darwin"* ]]; then
    accept_xcode_license
fi

# Function to install Homebrew on macOS if not present
install_homebrew() {
    echo "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [ $? -ne 0 ]; then
            echo "Failed to install Homebrew. Please try manually."
            exit 1
        fi
    else
        echo "Homebrew is already installed."
    fi
}

# Function to install Python 3.10 or higher
install_python() {
    echo "Installing Python 3.10 or higher..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_homebrew
        brew install python
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y python3.10 python3.10-venv python3.10-dev
            sudo ln -sf /usr/bin/python3.10 /usr/bin/python3
        elif command -v yum &> /dev/null; then
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

# Check if Python is installed
check_python_installed

# Check if Git is installed, install if not
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_homebrew
        brew install git
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y git || sudo yum install -y git
    else
        echo "Unsupported OS. Please install Git manually."
        exit 1
    fi
fi

# Add the user-specific Python bin directory to PATH if Apio is installed there
export PATH="$PATH:$(python3 -m site --user-base)/bin"

# Check if pip is installed, install if not
if ! command -v pip3 &> /dev/null; then
    echo "pip is not installed. Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user
    if [ $? -ne 0 ]; then
        echo "Failed to install pip. Please try manually."
        exit 1
    fi
    rm get-pip.py
fi

# Upgrade pip to the latest version
echo "Upgrading pip..."
python3 -m pip install --upgrade pip
if [ $? -ne 0 ]; then
    echo "Failed to upgrade pip. Please try manually."
    exit 1
fi

# Check if Apio is installed, install if not
if ! command -v apio &> /dev/null; then
    echo "Apio is not installed. Installing Apio..."
    pip3 install --user -U apio
    if [ $? -ne 0 ]; then
        echo "Failed to install Apio. Make sure pip is working correctly."
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
    apio init -b "go-board"
    if [ $? -ne 0 ]; then
        echo "Failed to create apio.ini. Please check the board name and try again."
        exit 1
    fi
fi

# Upload the code to the Go Board
echo "Uploading code to the Go Board..."
apio install oss-cad-suite
apio upload
if [ $? -ne 0 ]; then
    echo "Upload failed. Make sure the FPGA board is connected and try again."
    exit 1
fi

echo "Upload completed successfully. Please connect the VGA cable and power the board."
