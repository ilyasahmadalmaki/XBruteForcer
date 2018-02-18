clear
echo "
██╗  ██╗ ██████╗ ██████╗ ██╗   ██╗████████╗███████╗ ███████╗ ██████╗ ██████╗  ██████╗███████╗██████╗ 
╚██╗██╔╝ ██╔══██╗██╔══██╗██║   ██║╚══██╔══╝██╔════╝ ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗
 ╚███╔╝  ██████╔╝██████╔╝██║   ██║   ██║   █████╗   █████╗  ██║   ██║██████╔╝██║     █████╗  ██████╔╝
 ██╔██╗  ██╔══██╗██╔══██╗██║   ██║   ██║   ██╔══╝   ██╔══╝  ██║   ██║██╔══██╗██║     ██╔══╝  ██╔══██╗
██╔╝ ██╗ ██████╔╝██║  ██║╚██████╔╝   ██║   ███████╗ ██║     ╚██████╔╝██║  ██║╚██████╗███████╗██║  ██║
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝ ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝

██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
";

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/XBruteForcer"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/XBruteForcer"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.XBruteForcer"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    ICON="/usr/share/icons"
    APP="/usr/share/applications"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory XBruteForcer was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/XBruteForcer*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/XBruteForcer*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/Moham3dRiahi" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/Moham3dRiahi"
    else
        sudo rm -rf "$ETC_DIR/Moham3dRiahi"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/Moham3dRiahi/XBruteForcer "$INSTALL_DIR";
echo "#!$BASH_PATH
perl $INSTALL_DIR/XBruteForcer.pl" '${1+"$@"}' > "$INSTALL_DIR/XBruteForcer";
chmod +x "$INSTALL_DIR/XBruteForcer";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/XBruteForcer" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/XBruteForcer" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/password.png" "$ICON"
    sudo cp "$INSTALL_DIR/XBruteForcer.desktop" "$APP"
fi
rm "$INSTALL_DIR/XBruteForcer";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing XBruteForcer !   [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
