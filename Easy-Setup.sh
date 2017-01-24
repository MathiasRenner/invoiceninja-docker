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
echo "alias instart='docker-compose -f $(pwd)/docker-compose.yml up -d && xdg-open http://localhost:8080/ >>/dev/null'" >> ~/.bashrc
echo "alias instop='docker-compose -f $(pwd)/docker-compose.yml stop'" >> ~/.bashrc
echo "alias inclean='echo Cleaning initiated... && docker-compose -f $(pwd)/docker-compose.yml down && docker-compose -f $(pwd)/docker-compose.yml up -d && echo Waiting 30 seconds for services to start up... && sleep 30 && xdg-open http://localhost:8080/ >>/dev/null && echo Clean up done.'" >> ~/.bashrc
echo OK
. ~/.bashrc
echo -e "\e[1mSetup finished! Next, close this terminal and open a new one. Run 'instart' to start InvoiceNinja. \nYour browser will automatically start. Wait 10 seconds and refresh the page. Have fun!\e[0m"
