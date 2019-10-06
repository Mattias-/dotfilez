# My Dotfiles

## Zero to Hero, get running fast.

### Install Arch Linux

Boot from bootable stick
```bash
setfont sun12x22
wifi-menu
curl -LO https://raw.githubusercontent.com/Mattias-/dotfilez/master/install_arch.sh
vim ./install_arch.sh
bash ./install_arch.sh
```


### Post-install

```bash
wifi-menu
git clone --recursive https://github.com/Mattias-/dotfilez
./dotfilez/setup_arch
./dotfilez/setup_dotfiles.py
```
