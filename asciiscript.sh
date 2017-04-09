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
echo "Setting up Gym. Estimated completion time: 5-10 minutes."
echo "Your password will be requested to install Homebrew. 
echo ">> Press ENTER to begin <<"
echo 
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 1) Create OpenAIGym folder"
echo "*********************************"
pause 1
dir="OpenAIGym"
if [ ! -d $dir ]; then
     mkdir $dir
fi
cd $dir

echo
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 2) Setup Homebrew"
echo "*********************************"
pause 1
echo
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

echo
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 3) Setup Python 3 / Conda"
echo "*********************************"
pause 1
echo
which -s conda 
if [[ $? != 0 ]] ; then
    # Install conda
    bash <(curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh)
else
    conda update conda
fi

echo
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 4) Install OpenAI Gym"
echo "*********************************"
pause 1
echo
pip install gym

echo
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 5) Install Gym Dependencies"
echo "*********************************"
pause 1
echo
brew install cmake boost boost-python sdl2 swig wget

echo
echo "**** OPENAI GYM SETUP SCRIPT ****"
echo "Part 6) Installation complete! Testing a safety environment"
echo "*********************************"
pause 1
echo
open .

echo "Detecting dependencies"
echo "Need to install x,y,z"
echo "Installing c"
