# curl
	sudo apt install curl

# FiraCode Nerd Font
	cd ~/Downloads
	curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
	#	Need to shallow clone the repo and use the install.sh script instead maybe
	git@github.com:ryanoasis/nerd-fonts.git
	#	Extract it first and delete used files after
	sudo mv FiraCode/ /usr/share/fonts/FiraCode/

# Starship CLI
	curl -sS https://starship.rs/install.sh | sh
	# 	Add this to end of .bashrc:
	#		eval "$(starship init bash)"
	# run:
	starship preset nerd-font-symbols -o ~/.config/starship.toml

# Change keybindings for:
#	- Folder & File Explorer = Super+F
#	- Web Browser = Super+B
#	- Terminal = Super+Return
#	- Close Window = Shift+Super+C

# rofi
	sudo apt install rofi
#	 add keybindings:
#		- rofi -show run = Super+P
#	 	- rofi -show ssh = Super+S
#		- rofi -show window = Alt+Tab
	sudo apt install git
	git clone https://github.com/dracula/rofi
	cp rofi/theme/config1.rasi ~/.config/rofi/config.rasi
	
#




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# OTHER
# 	- ranger
#	- i3-wm
#	-
