# ESX Install Script Made By MrArgon
# Feel Free to fork it and make it better :)
# This installes only ESX-Org Addons this will not install 3rd party addons if you want one added request it and I probably wont add it.
CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"
clear
echo "$(tput setaf 1)ESX Install Script By MrArgon $(tput setab 7)$(tput sgr 0)"
echo "$(tput setaf 1)If you would like to know what this installs please read the Read me in the github page $(tput setab 7)$(tput sgr 0)"
echo "$(tput setaf 1)Run as root - REQUIRED $(tput setab 7)$(tput sgr 0)"
echo "$(tput setaf 1)Please place this in the directory where you would like the server to be installed NOTE this creates a esx directory $(tput setab 7)$(tput sgr 0)"
echo "$(tput setaf 1)This will not install the SQL Files it will place a SQL file that you need to execute on your SQL Host $(tput setab 7)$(tput sgr 0)"
PS3='Please enter your choice: '
options=("Install required files" "Install FX Server" "Install ESX" "Quit")
select opt in "${options[@]}"; do
  case $opt in
  "Install required files")
    echo "There will be no output for this"
    echo "when it askes for a password enter one you will not forget"
    sudo apt-get install -qq git mysql-server -y
    echo "Required files are now installed move onto Server install"
    echo $opt
    ;;
  "Install FX Server")
    echo "Are you sure you would like your server installed in $PWD/esx"
    select yn in "Yes" "No"; do
      case $yn in
      Yes)
      	echo -e "\n\e[4mInstalling FX server this may take some time\e[0m"
        mkdir esx 
        cd esx 

        wget -q https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/627-10962cea887ff23b3ae1614b7152ca44c2ccbb35/fx.tar.xz
        tar xf fx.tar.xz
        echo -e "\\r${CHECK_MARK} Server is installed"
        git clone https://github.com/citizenfx/cfx-server-data.git server-data &> /dev/null
        echo -e "\\r${CHECK_MARK} Server Data Installed"
        cd server-data
        wget -q https://gist.githubusercontent.com/est4life1997/0c62552cec7043332dc2edbefd7f46a4/raw/536acd0d16a124fad3dd346162f11804b6d99487/server.cfg
        echo -e "\\r${CHECK_MARK} Server.cfg Installed"
        break
        ;;
      No)
        echo "1) Install required files  3) Option 3
2) Install FX Server      4) Quit
"
        break
        ;;
      esac
    done

    ;;

  "Install ESX")
    if [ -d resources ]; then
      echo "This will install all of the esx files in the resoucres directory are you sure you would like to continue? This will take a while!"
      select yn in Yes No; do
        case $yn in
        Yes)
          echo "Starting"
          bash <(curl -s https://gist.githubusercontent.com/est4life1997/67782bba8f2d4f53e73173d73135a785/raw/4f965c9e0a2aae299413545975d7c14e148cad29/esx_resource.sh)
          echo "1) Install required files  3) Option 3
2) Install FX Server      4) Quit
"
          ;;
        No)
          echo "1) Install required files  3) Install ESX 2) Install FX Server 4) Quit"
          ;;
        
        esac
      done
    else
      echo "$(tput setaf 1)RESOURCES FOLDER WAS NOT FOUND PLEASE CD INTO THE ESX FOLDER BEFORE CONTINUING DO NOT CD INTO RESOURCES $(tput setab 7)$(tput sgr 0)"
    fi
    ;;
  "Quit")
    echo "Closing..."
    exit 0
    ;;
  esac
done
