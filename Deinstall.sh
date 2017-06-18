#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then


echo -e "\e[100mStep 1/4 \e[44m Stopping invoiceninja...\e[0m"
instop


echo -e "\e[100mStep 1/4 \e[44m Removing related Docker images...\e[0m"
docker rmi invoiceninja/invoiceninja
docker rmi mariadb
echo Done.


echo -e "\e[100mStep 1/4 \e[44m Removing invoiceninja folder...\e[0m"
rm -rf $(cat ~/.bashrc | grep instart |  grep -o -P '(?<=-f).*(?=invoiceninja-docker/docker-compose.yml)')


echo -e "\e[100mStep 1/4 \e[44m Removing aliases...\e[0m"
sed -i "/\b\(invoiceninja|instart|instop|inclean|inbackup)\b/d" ~/.bashrc

source ~/.bashrc

echo Done.

else
  echo Cancelled by user. Exiting...
  exit 0
fi
