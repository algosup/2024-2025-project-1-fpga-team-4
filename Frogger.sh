#!/bin/bash

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

# Check if Python 3.10 or higher is installed, install if not
if ! command -v python3 &> /dev/null || [[ $(python3 --version | cut -d " " -f 2) < "3.10" ]]; then
    echo "Python 3.10 or higher is not installed. Installing Python..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_homebrew
        brew install python
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y python3 python3-pip || sudo yum install -y python3 python3-pip
    else
        echo "Unsupported OS. Please install Python manually."
        exit 1
    fi
fi

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

# Check if Apio is installed, install if not
if ! command -v apio &> /dev/null; then
    echo "Apio is not installed. Installing Apio..."
    pip3 install -U apio
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
    apio init -b "go-board"  # Replace "go-board" with the actual board name if different
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
