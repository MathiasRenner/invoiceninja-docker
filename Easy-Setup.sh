#!/bin/bash
set -e
echo -e "\e[100mStep 1/4 \e[44m Cloning repository...\e[0m"
git clone https://github.com/MathiasRenner/invoiceninja-docker.git
echo -e "\e[100mStep 2/4 \e[44m Changing into cloned repository...\e[0m"
cd invoiceninja-docker
echo OK
echo -e "\e[100mStep 3/4 \e[44m Pulling neccessary Docker images...\e[0m"
docker-compose pull
echo -e "\e[100mStep 4/4 \e[44m Adding Bash Aliases to simplify starting and stopping...\e[0m"
echo "alias instart='docker-compose -f $(pwd)/docker-compose.yml up -d && xdg-open http://localhost:8080/'" >> ~/.bashrc
echo "alias instop='docker-compose -f $(pwd)/docker-compose.yml stop'" >> ~/.bashrc
source ~/.bashrc
echo -e "\e[1mSetup finished! Now, just run 'instart' to start InvoiceNinja. Afterwards, your browser will show "Bad Gateway". Just wait 10 seconds and refresh the browser.\e[0m"
