#!/bin/bash

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

function banner(){

    echo -e "${red}"
    echo -e " █████╗ ██╗   ██╗████████╗ ██████╗ ██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗"
    echo -e "██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║  "
    echo -e "███████║██║   ██║   ██║   ██║   ██║██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║  "
    echo -e "██╔══██║██║   ██║   ██║   ██║   ██║██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║  (by Yorkox)"
    echo -e "██║  ██║╚██████╔╝   ██║   ╚██████╔╝██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║"
    echo -e "╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝"
}

function main(){
    
    banner
    sleep 0.2

    echo -e "${blue}"
    echo -e "1 -> Instalar dependencuas necesarias."
    sleep 0.2
    
    echo
    echo -e "2 -> Instalar Bspwm."
    sleep 0.2
    
    echo
    echo -e "3 -> Instalar Polybar, Picom, Rofi..."
    sleep 0.2
    
    echo
    echo -e "4 -> Todo en uno."
    sleep 0.2
    
    echo
    echo -e "5 -> Salir."
    sleep 0.2

    echo
    read -p "-> " opcion
    echo -e "${end}"

    if [ "$opcion" == "1" ]; then
	req
	fi

    if [ "$opcion" == "2" ]; then
	bspwmInstall
	fi

    if [ "$opcion" == "3" ]; then
	polybarInstall
	fi

    if [ "$opcion" == "4" ]; then
	all
	fi

}

function req(){
    
    echo -e "${red}[!]${yellow} Instalando dependencias..."
    sleep 2

    sudo apt-get update -y
    sudo apt install net-tools libuv1-dev build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev -y
    sudo apt install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
    sudo apt install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev -y
    sudo apt install bspwm rofi caja feh gnome-terminal scrot neovim xclip tmux acpi scrub bat wmname -y

    sleep 2
    echo -e "${green}[+]${blue} Dependencias instaladas correctamente."
    echo -e "${end}"
}

function bspwmInstall(){
    
    echo -e "${red}[!]${yellow} Instalando bspwm..."
    sleep 2

    git clone https://github.com/baskerville/bspwm.git
    mv bspwm/* .
    sudo rm -r bspwm/
    make

    sudo make install

    sudo rm -r artworks/ contrib/ doc/ src/ tests/ bspc bspc.o bspwm bspwm.o desktop.o events.o ewmh.o geometry.o helpers.o history.o jsmn.o LICENSE Makefile messages.o monitor.o parse.o pointer.o query.o README.md restore.o rule.o settings.o Sourcedeps stack.o subscribe.o tree.o VERSION window.o 2>/dev/null

    git clone https://github.com/baskerville/sxhkd.git
    mv sxhkd/* .
    sudo rm -r sxhkd/
    cd ../sxhkd
    make

    sudo make install

    mkdir ~/.config/bspwm
    mkdir ~/.config/sxhkd
    cp examples/bspwmrc ~/.config/bspwm/

    chmod +x ~/.config/bspwm/bspwmrc
    cp examples/sxhkdrc ~/.config/sxhkd/

    sudo rm -r contrib/ doc/ examples/ src/ grab.o helpers.o LICENSE Makefile parse.o README.md Sourcedeps sxhkd sxhkd.o types.o VERSION 2>/dev/null
    cp tools/sxhkdrc ~/.config/
    sxhkd

    echo -e "${green}[+]${blue} Bspwm instalado correctamente.${end}"
}

function polybarInstall(){
    
    echo -e "${red}[!]${yellow} Instalando polybar..."
    git clone --recursive https://github.com/polybar/polybar
    mv polybar/* .
    sudo rm -r polybar/
    cmake .
    make -j$(nproc)

    sudo make install

    sudo rm -r bin/ cmake/ CMakeFiles/ common/ config/ contrib/ doc/ generated-sources/ include/ lib/ libs/ polybar/ src/ tests/ banner.png build.sh CHANGELOG.md CMajeCache.txt cmake_install.cmake CMakeLists.txt compile_commands.json CONTRIBUTING.md install_manifest LICENSE Makefile README.md SUPPORT.md version.txt 2>/dev/null

    git clone https://github.com/ibhagwan/picom.git
    mv picom/* .
    sudo rm -r picom/
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build

    sudo ninja -C build install

    sudo rm -r *.md *.conf *.desktop *.txt *.build *.spdx *.glsl COPYING Doxyfile CONTRIBUTORS bin/ build/ dbus-examples/ LICENSES/ man/ media/ meson/ src/ subprojects/ tests/ 2>/dev/null

    mkdir ~/.wallpapers
    cp tools/wallpaper.jpg ~/.wallpapers
    echo 'feh --bg-fill ~/.wallpapers/wallpaper.jpg' >> ~/.config/bspwm/bspwmrc
    echo 'xsetroot -cursor_name left_ptr &' >> ~/.config/bspwm/bspwmrc
    echo 'wmname LG3D &' >> ~/.config/bspwm/bspwmrc

    git clone https://github.com/VaughnValle/blue-sky.git
    mkdir ~/.config/polybar

    cp tools/polybar-backup.zip .
    unzip polybar-backup.zip
    sudo mv polybar-backup/ ~/.config/
    sudo rm -r ~/.config/polybar/ 2>/dev/null
    sudo mv ~/.config/polybar-backup/ ~/.config/polybar/
    echo '~/.config/polybar/./launch.sh' >> ~/.config/bspwm/bspwmrc

    mkdir ~/.config/picom
    echo 'bspc config focus_follows_pointer true' >> ~/.config/bspwm/bspwmrc

    cp tools/picom.conf ~/.config/picom

    echo 'bspc config border_width 0' >> ~/.config/bspwm/bspwmrc
    mkdir ~/.config/bin
    echo 'picom --experimental-backends &' >> ~/.config/bspwm/bspwmrc

    sudo cp ~/.config/polybar/fonts/* /usr/share/fonts

    wget https://raw.githubusercontent.com/yorkox0/exaple01/main/ethernet_status.sh
    chmod +x ethernet_status.sh 2>/dev/null
    mv ethernet_status.sh ~/.config/bin
    wget https://raw.githubusercontent.com/yorkox0/exaple01/main/hackthebox.sh
    chmod +x hackthebox.sh
    mv hackthebox.sh ~/.config/bin
    cp tools/target_to_hack.sh .
    chmod +x target_to_hack.sh
    mv target_to_hack.sh ~/.config/bin
    echo '' > ~/.config/bin/target
    chmod +x tools/battery.sh
    mv tools/battery.sh ~/.config/bin/
    echo '' > ~/.config/bin/target

    mkdir ~/.config/rofi
    mkdir ~/.config/rofi/themes
    cp blue-sky/nord.rasi ~/.config/rofi/themes

    sudo cp tools/settarget /bin
    sudo cp tools/cleartarget /bin
    sudo chmod +x /bin/settarget
    sudo chmod +x /bin/cleartarget

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k
    sudo echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc

    cp tools/zshrc_conf ~/.zshrc

    cp tools/Hack.zip .
    unzip Hack.zip
    sudo mv *.ttf /usr/share/fonts
    rm *.zip

    wget https://github.com/arcticicestudio/nord-vim/archive/master.zip
    unzip master.zip
    rm master.zip
    mkdir ~/.config/nvim
    mv nord-vim-master/colors/ ~/.config/nvim
    sudo rm -r nord-vim-master/
    wget https://raw.githubusercontent.com/Necros1s/lotus/master/lotus.vim
    wget https://raw.githubusercontent.com/Necros1s/lotus/master/lotusbar.vim
    wget https://raw.githubusercontent.com/Necros1s/lotus/master/init.vim
    mv *.vim ~/.config/nvim
    echo 'colorscheme nord' >> ~/.config/nvim/init.vim
    echo 'syntax on' >> ~/.config/nvim/init.vim

    git clone https://github.com/gpakosz/.tmux.git /home/$USER/.tmux
    ln -s -f .tmux/.tmux.conf /home/$USER
    cp /home/$USER/.tmux/.tmux.conf.local /home/$USER

    sudo git clone https://github.com/gpakosz/.tmux.git /root/.tmux
    sudo ln -s -f .tmux/.tmux.conf /root
    sudo cp /root/.tmux/.tmux.conf.local /root

    chmod +x tools/fastTCPscan.go
    sudo cp tools/fastTCPscan.go /bin

    chmod +x tools/wichSystem.py
    sudo mv tools/wichSystem.py /bin/

    sudo dpkg -i tools/lsd.deb

    echo -e "${green}[+]${blue} Polybar instalado correctamente.${end}"
}

function all(){
    
    req
    bspwmInstall
    polybarInstall
    exit -1
}

if [ "$(id -u)" == "0" ]; then
	
    echo -e "\n${red}[!] No hay que ser root para ejecutar la herramienta${end}"
	echo
	exit 1
else
	main
fi
