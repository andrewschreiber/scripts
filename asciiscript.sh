#!/bin/sh
set -e

command_exists () {
    type "$1" &> /dev/null ;
}

safe_brew_install () {
    while [ $# -gt 0 ]
    do
        if brew ls --versions "$1" > /dev/null ; then 
           echo "[CHECK] $1 already installed."
        else
           echo "Installing $1..."
           brew install "$1"
        fi
    shift
    done
}



tput setaf 54
echo "                                    ▄▄▄▄▄▄"
echo "                                  ▄▓▀    ▓▓▓██▄▄"
echo "                               ▄▄▓▓  ▄▄▓▀▀     ▀▓▄"
echo "                             ▄▓▀ ▓▌ ▐▓  ▄▄█▀▓▓▄  ▓▌"
echo "                            ▐▓▌  ▓▌ ▐▓█▀▀▀▄▄  ▀▀▓▓▌"
echo "                             ▓▌  ▓▌ ▐▌    ▐▓▀█▄  ▀▓▄"
echo "                              ▓▓▄ ▀▀▀▓▄  ▄▄▓  ▓▌  ▓▌"
echo "                              ▓▌▀▀▓▄▄▄▄▓▀ ▐▓  ▓▌ ▄▓▀"
echo "                              ▀▓▄   ▀▀  ▄▄▓▀ ▐▓▓▓▀"
echo "                                ▀▓▄▄▄▄▓▀▀    ▓▓"
echo "                                      ▀▓▓▓▓▓▀▀"
echo "      ▄▄▄▓▓▄▄▄                                          ▄▄▄      ████████"
echo "    ▄▓▓▀▀  ▀▀▓▓▄                                       ▓▓▀▓▌        ▓▓▌"
echo "    ▓▓▌      ▐▓▓  ▓▓▄▓▓▓▓▓▄   ▄▓▓▀█▓▄   ▓▓▄▓▓▓▓▓▄     ▓▀  ▓▓▄       ▓▓▌"
echo "    ▓▓▌      ▐▓▓  ▓▓    ▀▓▓  ▓▓▌    ▓▓  ▓▓▌   ▐▓▓    ▐▓▌   ▓▓       ▓▓▌"
echo "    ▓▓▌      ▐▓▓  ▓▌    ▐▓▓  ▓▓▓██████  ▓▓▌   ▐▓▓   ▐▓▓▄▄▄▄▓▓▓      ▓▓▌"
echo "    ▀▓▓▄    ▄▓▓▀  ▓▓▄   ▄▓▓  ▓▓▌    ▄▄  ▓▓▌   ▐▓▓   ▓▓▀▀▀▀▀▀▓▓▌     ▓▓▌"
echo "      ▀▀█▓▓█▀▀    ▓▌▀████▀    ▀▀█▓██▀   ▓▓▌   ▐▓▓  ██▀       ██  ████████"
echo "                  ▓▌                                                     "
echo "                  ▓▌                                                     "
tput sgr0
echo; echo "Setting up Gym & dependencies. Takes 5-20 minutes, based on internet speed."

if command_exists xcode-select ; then 
  echo "Installing Xcode Command Line Tools..."
  clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
  sudo "/usr/bin/touch", clt_placeholder
  softwareupdate -l | grep -B 1 -E "Command Line (Developer|Tools)" | awk -F"*" '/^ +\\*/ {print $2}' | sed 's/^ *//' | tail -n1
  echo "Installing $clt_label"
  sudo "/usr/sbin/softwareupdate", "-i", clt_label
  sudo "/bin/rm", "-f", clt_placeholder
  sudo "/usr/bin/xcode-select", "--switch", "/Library/Developer/CommandLineTools"
else
  echo "Command line tools exist"
fi


read -rsp $'>> Press enter to begin <<\n'

echo;echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 1) OpenAIGym folder"
echo "*********************************"; echo

sleep 1
dir="OpenAIGym"
if [ "${PWD##*/}" != $dir ]; then 
     if [ ! -d $dir ]; then
          mkdir $dir
     fi
     cd "$dir"
fi

echo "(Part 1) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 2) Setup Homebrew"
echo "*********************************"; sleep 1; echo
echo "Reaching out to Homebrew..."

if command_exists brew ; then
    echo "Brew already installed. Moving forward."
else
    echo "Installing Homebrew. Enter your system password at prompt, then press enter."
    echo "(Tip) You will have a few minutes to grab coffee."
    sleep 8
    echo "Downloading Homebrew..."
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "(Part 2) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 3) Setup Python 3 / Conda"
echo "(Tip) Say yes to each prompt that asks"
echo "(Tip) Scroll down the license by holding enter"
echo "*********************************"; echo
read -rsp $'>> Press enter to continue <<\n'

if command_exists conda ; then
    
    echo "Updating conda..."
    conda update conda
    case "$(python --version 2>&1)" in
    *" 3.6"*)
        echo "Using Python 3.6 already. Continuing..."
        ;;
    *)
        echo "Switching to Python 3.6 using Conda..."
        
        set +e
        conda create -n p36 python=3.6
        set -e
        source activate p36
        echo "(Tip) New terminal tabs/windows must run 'source activate p36' for Gym"
        echo "(Tip) Add the above command to your .bash_profile for auto-activation"
        read -rsp $'>> Press enter to continue <<\n'
        ;;
     esac
else
    # Install conda
    echo "Installing Miniconda..."
    safe_brew_install wget
    
    set +e
    # if file exists skip
    wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    chmod +x Miniconda3-latest-MacOSX-x86_64.sh
    set -e
    ./Miniconda3-latest-MacOSX-x86_64.sh
    rm Miniconda3-latest-MacOSX-x86_64.sh
    source ~/.bash_profile
    echo "(Tip) For Conda to work, restart Terminal after the script completes."
    read -rsp $'>> Press enter to continue <<\n'
fi

echo "(Part 3) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 4 | Configure Dependencies"
echo "*********************************"; sleep 1; echo

safe_brew_install cmake swig boost boost-python sdl2 wget

echo "(Part 4) Success!"
echo;echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 5) Install OpenAI Gym"
echo "(Tip) The pachi-py step takes a few minutes."
echo "*********************************"; sleep 1; echo

pip install 'gym[all]'

echo "(Part 5) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 6) Download and run an example agent"
echo "*********************************"; sleep 1; echo

set +e
#check if file already exists
wget -c https://raw.githubusercontent.com/andrewschreiber/scripts/master/example_safety_agent.py
set -e
# Q: How many sample agents should we download?
# A: One for each exercise. Perhaps with hyperparameters generated by random.

read -rsp $'>> Press enter to start example_safety_agent <<\n'
python example_safety_agent.py

echo; echo
tput setaf 54
echo "  ███████╗ ██╗   ██╗  ██████╗  ██████╗ ███████╗ ███████╗ ███████╗    ██╗"
echo "  ██╔════╝ ██║   ██║ ██╔════╝ ██╔════╝ ██╔════╝ ██╔════╝ ██╔════╝    ██║"
echo "  ███████╗ ██║   ██║ ██║      ██║      █████╗   ███████╗ ███████╗    ██║"
echo "  ╚════██║ ██║   ██║ ██║      ██║      ██╔══╝   ╚════██║ ╚════██║    ╚═╝"
echo "  ███████║ ╚██████╔╝ ╚██████╗ ╚██████╗ ███████╗ ███████║ ███████║    ██╗"
echo "  ╚══════╝  ╚═════╝   ╚═════╝  ╚═════╝ ╚══════╝ ╚══════╝ ╚══════╝    ╚═╝"
tput sgr0
echo; echo; echo "Open AI Gym setup complete."
