#!/bin/bash
set -e

echo -e "Would you like to configure email now? Then type 'y'. If you want to configure it later, type 'n':"
read usersettings

if [[ $usersettings == y ]]; then

    echo -e "\e[100mStep 1/4 \e[44m Collecting user settings...\e[0m"

    echo "Type your email adress (e.g. mail@example.com) [ENTER]:"
    read mailaddress

    echo "Type your email host address (e.g. mail.example.com) and then press [ENTER]:"
    read mailhost

    echo "Type your email username (often identical with your email address) [ENTER]:"
    read mailusername

    echo "Type your email password [ENTER]:"
    read mailpassword

    echo "Type the name the email receiver should see as email sender (often full personal or company name) [ENTER]:"
    read mailfromname
fi

echo -e "\e[100mStep 2/5 \e[44m Cloning repository...\e[0m"
git clone https://github.com/MathiasRenner/invoiceninja-docker.git
cd invoiceninja-docker
echo OK


if [[ $usersettings == y ]]; then

    echo -e "\e[100mStep 3/5 \e[44m Writing user config...\e[0m"

    sed -i -- "s/mail@example.com/$mailaddress/" docker-compose.yml
    sed -i -- "s/mail.service.host/$mailhost/" docker-compose.yml
    sed -i -- "s/username/$mailusername/" docker-compose.yml
    sed -i -- "s/password/$mailpassword/" docker-compose.yml
    sed -i -- "s/fromname/$mailfromname/" docker-compose.yml

    echo OK
fi

if [[ $usersettings == n ]]; then
  echo -e "\e[100mStep 2/5 \e[44m No user config available. Skipping to write user config ...\e[0m"
fi

echo -e "\e[100mStep 4/5 \e[44m Pulling neccessary Docker images...\e[0m"
docker-compose pull


echo -e "\e[100mStep 5/5 \e[44m Adding Bash Aliases to simplify starting and stopping...\e[0m"
echo "alias instart='docker-compose -f $(pwd)/docker-compose.yml up -d && xdg-open http://localhost:8080/ >>/dev/null'" >> ~/.bashrc
echo "alias instop='docker-compose -f $(pwd)/docker-compose.yml stop'" >> ~/.bashrc
echo "alias inclean='echo Cleaning initiated... && docker-compose -f $(pwd)/docker-compose.yml down && docker-compose -f $(pwd)/docker-compose.yml up -d && echo Waiting 30 seconds for services to start up... && sleep 30 && xdg-open http://localhost:8080/ >>/dev/null && echo Clean up done.'" >> ~/.bashrc
echo OK
. ~/.bashrc


echo -e "\e[1mSetup finished! Next, close this terminal and open a new one. Run 'instart' to start InvoiceNinja. \nYour browser will automatically start. Wait 10 seconds and refresh the page. Have fun!\e[0m"
