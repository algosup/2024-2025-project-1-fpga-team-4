#!/bin/bash

#######################################################################
# Functions
#######################################################################

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

# Function to install Python 3.10 or higher on macOS
install_python() {
    echo "Installing Python 3.10 or higher..."
    install_homebrew
    brew install python
}

# Function to check and install pip if necessary
install_pip() {
    echo "Checking if pip is installed..."
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
}

# Function to install Apio if not installed
install_apio() {
    echo "Checking if Apio is installed..."
    if ! command -v apio &> /dev/null; then
        echo "Apio is not installed. Installing Apio..."
        pip3 install --user -U apio
        if [ $? -ne 0 ]; then
            echo "Failed to install Apio. Please try manually."
            exit 1
        fi
    fi
}

# Function to pause and give instructions for manual tasks
pause_for_manual_task() {
    echo -e "\n*** Manual Step Required: $1 ***"
    echo "Once you have completed the step, press Enter to continue..."
    read -p ""
}

# Function to pause and give information for manual tasks
pause_for_info() {
    echo -e "\n*** Information: $1 ***"
    echo "Press Enter to continue..."
    read -p ""
}

# Function to install Apio on Windows
install_apio_windows() {
    echo "Checking if Apio is installed..."
    if ! command -v apio &> /dev/null; then
        echo "Apio is not installed. Installing Apio..."
        python -m pip install apio
        if [ $? -ne 0 ]; then
            echo "Failed to install Apio. Please try manually."
            exit 1
        fi
    fi
}

# Function to handle Apio drivers on Windows
install_apio_drivers_windows() {
    echo "Installing Apio drivers for FTDI..."
    apio install -a
    pause_for_manual_task "A screen is going to appear, once you click enter. \n In the dropdown, select Dual RS232-HS (Interface 0). \n In the driver, after the arrow, select libusbK. \n Click on Reinstall Driver. \n This operation can take a couple of minutes. \n Finally, close the Zadig window."
    apio drivers --ftdi-enable
    if [ $? -ne 0 ]; then
        echo "Failed to enable FTDI drivers. Please try manually."
        
    fi
}

# Function to check if the script is running with admin privileges on Windows
is_admin() {
    net session > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "This script is not running as Administrator."
        return 1
    else
        echo "This script is running with Administrator privileges."
        return 0
    fi
}

#######################################################################
# Main Script
#######################################################################

# Detect OS
OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "Linux" ]]; then
    echo "You are running on Linux."
    # Add Linux-specific actions
    pause_for_manual_task "Please execute the script on a macOS or Windows machine."
    exit 1
    
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "You are running on macOS."

    pause_for_manual_task "Plug the Go Board into your computer."

    # Step 1: Check and accept the Xcode license
    accept_xcode_license

    # Step 2: Check and install Python 3.10 or higher
    check_python_installed

    # Step 3: Check and install Git
    echo "Checking if Git is installed..."
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Installing Git..."
        install_homebrew
        brew install git
    else
        echo "Git is already installed."
    fi

    # Step 4: Install pip (if not installed)
    install_pip

    # Step 5: Upgrade pip
    echo "Upgrading pip..."
    python3 -m pip install --upgrade pip
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade pip. Please try manually."
        exit 1
    fi

    # Step 6: Install Apio (if not installed)
    install_apio

    # Step 7: Clone the GitHub repository (if not already cloned)
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

    # Step 8: Navigate to the project directory
    cd "$REPO_DIR" || { echo "Failed to navigate to the project directory."; exit 1; }
    cd src

    # Step 9: Check if apio.ini exists; if not, initialize it
    if [ ! -f "apio.ini" ]; then
        echo "Creating apio.ini file with the specified board."
        apio init -b "go-board"
        if [ $? -ne 0 ]; then
            echo "Failed to create apio.ini. Please check the board name and try again."
            exit 1
        fi
    fi

    # Step 10: Install OSS-CAD Suite with Apio
    echo "Installing OSS-CAD Suite..."
    apio install oss-cad-suite
    if [ $? -ne 0 ]; then
        echo "Failed to install OSS-CAD Suite. Please try again."
        exit 1
    fi

    # Step 11: Upload the code to the Go Board
    echo "Uploading code to the Go Board..."
    apio upload
    if [ $? -ne 0 ]; then
        echo "Upload failed. Make sure the FPGA board is connected and try again."
        exit 1
    fi

    echo "Upload completed successfully. Please connect the VGA cable and power the board."

elif [[ "$OS_TYPE" == "MINGW64_NT"* || "$OS_TYPE" == "MSYS_NT"* ]]; then
    echo "You are running on Windows."

    if is_admin; then
        echo "Proceeding as Administrator."
    else
        pause_for_manual_task "Rerun the script as Administrator"
        exit 1
    fi

    read -p "Have you already run the game before? (Y/N): " user_response
    if [[ "$user_response" == "Y" ]]; then
        # Skip to step 7
        echo "Skipping to step 7: Uploading code to the Go Board..."
        cd "$REPO_DIR/src" || { echo "Failed to navigate to the project directory."; exit 1; }
        echo "Uploading code to the Go Board..."
        apio upload
        if [ $? -ne 0 ]; then
            echo "Upload failed. Make sure the FPGA board is connected and try again."
            exit 1
        fi
        echo "Upload completed successfully. Please connect the VGA cable and power the board."
        exit 0
    fi

    # Step 1: Check if Python 3.9 or higher is installed, ask the user to install manually if not
    echo "Checking if Python 3.9 or higher is installed..."
    if command -v python &> /dev/null; then
        PYTHON_VERSION=$(python --version | cut -d " " -f 2)
        PYTHON_MAJOR=$(echo "$PYTHON_VERSION" | cut -d "." -f 1)
        PYTHON_MINOR=$(echo "$PYTHON_VERSION" | cut -d "." -f 2)

        if [[ "$PYTHON_MAJOR" -eq 3 && "$PYTHON_MINOR" -ge 9 ]] || [[ "$PYTHON_MAJOR" -gt 3 ]]; then
            echo "Python 3.9 or higher is installed (version: $PYTHON_VERSION)."
        else
            echo "Python version is lower than 3.9 (version: $PYTHON_VERSION)."
            pause_for_manual_task "Please install Python 3.9 or higher from https://www.python.org/ and rerun the script. Press Enter to exit."
            exit 1
        fi
    else
        echo "Python 3 is not installed."
        pause_for_manual_task "Please install Python 3.9 or higher from https://www.python.org/ and rerun the script. Press Enter to exit."
        exit 1
    fi


    # Step 2: Install Apio
    install_apio_windows

    # Step 3: Pause for manual instructions
    pause_for_manual_task "Please plug in the Go Board to your computer."

    # Step 4: Install Apio drivers and enable FTDI drivers
    install_apio_drivers_windows

    # pause_for_info "A screen just appear, please follow the user manual for this next step. Press Enter to continue, once done."

    pause_for_manual_task "Please unplug the Go Board and plug it back to your computer. Press Enter to continue."

    # Step 5: Clone the GitHub repository (if not already cloned)
    REPO_URL="https://github.com/algosup/2024-2025-project-1-fpga-team-4"
    REPO_DIR="2024-2025-project-1-fpga-team-4"

    if [ ! -d "$REPO_DIR" ]; then
        echo "Cloning the GitHub repository..."
        git clone "$REPO_URL"
        if [ $? -ne 0 ]; then
            echo "Failed to clone the repository."
            exit 1
        fi
    else
        echo "Repository already cloned."
    fi

    # Step 6: Navigate to the project directory
    cd "$REPO_DIR/src" || { echo "Failed to navigate to the project directory."; exit 1; }

    # Step 7: Upload the code to the Go Board
    echo "Uploading code to the Go Board..."
    apio upload
    if [ $? -ne 0 ]; then
        echo "Upload failed. Make sure the FPGA board is connected and try again."
        exit 1
    fi

    echo "Upload completed successfully. Please connect the VGA cable and power the board."

else
    echo "Unknown operating system."
    exit 1
fi
