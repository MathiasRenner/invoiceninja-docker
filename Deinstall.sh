#!/bin/bash
set -e

read -r -p "Are you sure to completely remove Invoiceninja? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then

echo -e "\e[100mStep 1/4 \e[44m Stopping invoiceninja...\e[0m"
docker-compose -f $(cat ~/.bashrc | grep instop |  grep -o -P '(?<=-f).*(?=stop)') down
echo OK

echo -e "\e[100mStep 2/4 \e[44m Removing related Docker images...\e[0m"
docker rmi $(docker image ls | grep mariadb | tr -s ' ' | cut -d ' ' -f 3)
docker rmi $(docker image ls | grep invoiceninja | tr -s ' ' | cut -d ' ' -f 3)
echo OK

echo -e "\e[100mStep 3/4 \e[44m Removing invoiceninja folder...\e[0m"
cd $(cat ~/.bashrc | grep instart |  grep -o -P '(?<=-f).*(?=docker-compose.yml)')
cd ..
echo Sudo is required to move forward...
sudo rm -rf invoiceninja-docker

echo -e "\e[100mStep 4/4 \e[44m Removing aliases...\e[0m"
sed -i "/\b\(invoiceninja\|instart\|instop\|inclean\|inbackup\)\b/d" ~/.bashrc
source ~/.bashrc
echo OK

echo All done.

else
  echo Cancelled by user. Exiting...
  exit 0
fi
