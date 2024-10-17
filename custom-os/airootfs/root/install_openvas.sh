#!/bin/bash
# Install OpenVAS and its dependencies

# Install AUR helper yay
sudo pacman -S --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Install OpenVAS via AUR
yay -S --noconfirm gvm

# Configure PostgreSQL for GVM
sudo -iu postgres
initdb --locale en_US.UTF-8 -D /var/lib/postgres/data
exit
sudo systemctl start postgresql
sudo systemctl enable postgresql

sudo -iu postgres
createuser gvm --no-superuser --createdb --no-createrole --pwprompt
createdb -O gvm gvmd
exit

# Configure Redis for GVM
sudo sed -i 's/# unixsocket /unixsocket /' /etc/redis/redis.conf
sudo sed -i 's/# unixsocketperm /unixsocketperm /' /etc/redis/redis.conf
sudo systemctl start redis
sudo systemctl enable redis
sudo usermod -aG redis gvm

# Synchronize GVM feeds
sudo gvm-setup

# Start OpenVAS services
sudo systemctl start gvmd
sudo systemctl start gsad
sudo systemctl start openvas-scanner
sudo systemctl enable gvmd
sudo systemctl enable gsad
sudo systemctl enable openvas-scanner

# Notify that OpenVAS is ready
echo "OpenVAS (GVM) setup complete. Access the web interface at https://localhost:9392"
