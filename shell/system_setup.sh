#!/bin/sh -x

# This file is a general setup file that install most files and programs I would use on a Debian Machine

# Directory you want /ws set up in
WS_DIR=/home/pat
USERNAME=pat
GIT_EMAIL="patrickrhoey@gmail.com"
GIT_USERNAME="PatrickCPE"
GITHUB_USERNAME="PatrickCPE"
GITLAB_USERNAME="PatrickCPE"

# Configure flags based upon what you need done
FLAG_MKDIR=0
FLAG_APT=0
FLAG_DEV=0
FLAG_SYS=0
FLAG_GEN=0
FLAG_MEME=0
FLAG_PYTHON=0
FLAG_COMPILE=0
FLAG_CONFIG=1
FLAG_CFG_ATTRIB=0
FLAG_SPACEMACS=0
FLAG_CFG_FILES=1

#------------------------------------------------------------------------------------------------------
#	Typical Environment Setup
#------------------------------------------------------------------------------------------------------
if [ $FLAG_MKDIR = 1 ]
then
	runuser -u $USERNAME -- mkdir $WS_DIR/ws
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/scripts
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/scripts/shell
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/scripts/python
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/scripts/elisp
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/projects
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/notes
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/notes/org
	runuser -u $USERNAME -- mkdir $WS_DIR/ws/dotfiles
fi
#------------------------------------------------------------------------------------------------------
#	APT Packages
#------------------------------------------------------------------------------------------------------

if [ $FLAG_APT = 1 ]
then
	# Development
	if [ $FLAG_DEV = 1 ]
	then
		apt-get install -y neovim
		apt-get install -y tmux
		apt-get install -y terminator
		apt-get install -y git
    apt-get install -y git-flow
		apt-get install -y octave
		apt-get install -y iverilog
		apt-get install -y python3
		apt-get install -y python3-pip
		apt-get install -y clang
		apt-get install -y clang-format
    apt-get install -y pandoc
	fi
	# System
	if [ $FLAG_SYS = 1 ]
	then
		apt-get install -y curl
		apt-get install -y i3
		apt-get install -y htop
		apt-get install -y tree
		apt-get install -y neofetch
		apt-get install -y nmap
		apt-get install -y zsh
		apt-get install -y fish
		apt-get install -y valgrind
		apt-get install -y wireshark-qt
		apt-get install -y redshift
		apt-get install -y brightnessctl
		apt-get install -y volumeicon-alsa
		apt-get install -y keepassxc
		apt-get install -y npm
	fi
	# General Purpose
	if [ $FLAG_GEN = 1 ]
	then
		apt-get install -y vlc
		apt-get install -y obs-studio
		add-apt-repository -y ppa:kdenlive/kdenlive-stable
		apt-get install -y kdenlive
		apt-get install -y calibre
		apt-get install -y anki
		apt-get install -y drawing
		apt-get install -y gimp
		apt-get install -y ffmpeg
    apt-get install -y pyvenv
	fi
	# Memery
	if [ $FLAG_MEME = 1 ]
	then
		apt-get install -y fortune
		apt-get install -y cowsay
		apt-get install -y sl
	fi
fi

#------------------------------------------------------------------------------------------------------
#	Python Packages
#------------------------------------------------------------------------------------------------------
if [ $FLAG_PYTHON = 1 ]
then
	pip3 install cocotb
	pip3 install scipy
	pip3 install numpy
  	pip3 install 'python-lsp-server[all]'
  	pip3 install cmake-language-server
  	pip3 install flake8
  	pip3 install pytest
  	pip3 install yapf
  	pip3 install autoflake
  	pip3 install "ptvsd>=4.2"
  	pip3 install importmagic
  	pip3 install epc
	pip3 install argcomplete
	activate-global-python-argcomplete
fi

#------------------------------------------------------------------------------------------------------
#	Compiled Programs
#------------------------------------------------------------------------------------------------------
if [ $FLAG_COMPILE = 1 ]
then
	sh $WS_DIR/ws/scripts/shell/compule_scripts/emacs.sh
	sh $WS_DIR/ws/scripts/shell/compile_scripts/verilator.sh
	sh $WS_DIR/ws/scripts/shell/compile_scripts/yosys.sh
	sh $WS_DIR/ws/scripts/shell/compile_scripts/symbiyosys.sh
	sh $WS_DIR/ws/scripts/shell/compile_scripts/mcy.sh
fi

#------------------------------------------------------------------------------------------------------
#	Configure System
#------------------------------------------------------------------------------------------------------
if [ $FLAG_CONFIG = 1 ]
then
  if [ $FLAG_CFG_ATTRIB = 1 ]
  then
	   # These won't work when run as sudo
	   runuser -u $USERNAME -- git config --global user.email $GIT_EMAIL
	   runuser -u $USERNAME -- git config --global user.name $GIT_USERNAME
	   runuser -u $USERNAME -- git config --global github.user $GITHUB_USERNAME
	   runuser -u $USERNAME -- git config --global gitlab.user $GITLAB_USERNAME
     usermod -aG video ${USERNAME}
  fi

  if [ $FLAG_CFG_FILES = 1 ]
  then
     rm /home/$USERNAME/.bashrc
	   runuser -u $USERNAME -- ln -s $WS_DIR/ws/dotfiles/bashrc/.bashrc /home/$USERNAME/.bashrc
     rm /home/$USERNAME/.spacemacs
	   runuser -u $USERNAME -- ln -s $WS_DIR/ws/dotfiles/emacs/.spacemacs /home/$USERNAME/.spacemacs
     rm /home/$USERNAME/.config/terminator/config
	   runuser -u $USERNAME -- ln -s $WS_DIR/ws/dotfiles/terminator/config /home/$USERNAME/.config/terminator/config
     rm /home/$USERNAME/.config/i3/config
	   runuser -u $USERNAME -- ln -s $WS_DIR/ws/dotfiles/i3/config /home/$USERNAME/.config/i3/config
     rm /home/$USERNAME/.vimrc
	   runuser -u $USERNAME -- ln -s $WS_DIR/ws/dotfiles/vim/.vimrc /home/$USERNAME/.vimrc
  fi


	if [ $FLAG_SPACEMACS = 1 ]
	then
		runuser -u $USERNAME -- git clone https://github.com/syl20bnr/spacemacs /home/$USERNAME/.emacs.d
	fi
fi

echo "System setup complete"

