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
echo
echo "Setting up Gym. ETA: 5-10 minutes. Your password is needed for Homebrew install."
read -rsp $'>> Press enter to begin <<\n'

echo 
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 1) OpenAIGym folder"
echo "*********************************"
echo
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

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi
echo "(Part 2) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "(Part 3) Setup Python 3 / Conda"
echo "Say yes to each prompt that asks"
echo "Scroll down the license by pressing enter"
echo "*********************************"; echo
read -rsp $'>> Press enter to continue <<\n'

which -s conda 
if [[ $? != 0 ]] ; then
    # Install conda
    brew install wget
    wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    chmod +x Miniconda3-latest-MacOSX-x86_64.sh
    ./Miniconda3-latest-MacOSX-x86_64.sh
    rm Miniconda3-latest-MacOSX-x86_64.sh
    source ~/.bash_profile
    # TODO: Add checking which shell for sourcing
    # TODO: Need to get pip while in this current terminal, currently works only on the next terminal.
else
    conda update conda
fi

echo "(Part 3) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 4 | Install OpenAI Gym"
echo "*********************************"; sleep 1; echo
pip install 'gym[all]'

echo "(Part 4) Success!"
echo;echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 5 | Install Gym Dependencies"
echo "*********************************"; sleep 1; echo
brew install cmake boost boost-python sdl2 swigj

echo "(Part 5) Success!"
echo; echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 6 | Download and run an example agent"
echo "*********************************"; sleep 1; echo
wget -c https://raw.githubusercontent.com/andrewschreiber/scripts/master/example_safety_agent.py
python example_safety_agent.py

open .

echo "Detecting dependencies"
echo "Need to install x,y,z"
echo "Installing c"
