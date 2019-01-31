# InvoiceNinja for local machine only

InvoiceNinja is a great tool for business owners to process invoices. However it's implemented as a web service, which could expose clients' data to the Internet in case of security issues. Since security issues are not unlikely, this project here avoids security problems by running InvoiceNinja only on localhost.

This project simplifies the usage of [InvoiceNinja](https://github.com/invoiceninja/invoiceninja) leveraging [Docker](http://docker.com/) while maintaining a high level of security.

The project has been successfully tested on Ubuntu and Debian. Other Linux based operating systems might require adjustments to work fine.


Benefits of this setup
-----------
- **Security:** InvoiceNinja will run only on localhost without being accessible from any other machine.
- **Usability:**
  - InvoiceNinja can be started and stopped when needed within milliseconds.
  - Backups are as easy as copying one folder.


Drawbacks of this setup
------------
- The **client portal** of InvoiceNinja will not be accessible by clients, since it runs on localhost without being accessible from any other machine. In the portal, clients can see their invoices and download them. This is more secure than sending invoices via email, but a compromise of this setup.
- **Recurring invoices**, e.g. for monthly invoices for some maintenance contract, cannot be sent out regularly since InvoiceNinja is not constantly running as a daemon.


Easy Setup
---------------
Check prerequisites:
  - Setup `docker` and `docker-compose` following Docker's official docs. Make sure you have `docker-compose` version >= 1.6.
  - Make sure you can run `docker` commands without *sudo*. If you get an error like `permission denied` when running e.g. `docker ps`, [follow these instructions here](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo).
  - Make sure you have `git` installed.

Install:
  - Go to a folder, in which InvoiceNinja shall be downlaoded to (a new folder will be created). Then run:

```
curl -s https://raw.githubusercontent.com/MathiasRenner/invoiceninja-docker/master/Easy-Setup.sh -o Easy-Setup.sh && bash Easy-Setup.sh
```

If you prefer a step-by-step installation, follow the [manual setup instructions](https://github.com/MathiasRenner/invoiceninja-docker/blob/master/MANUAL-SETUP.md).


Start & stop
--------------
- To start InvoiceNinja, just run `instart`
- To stop it: `instop`


Backup & Restore
----------------
- **Backup**: All settings for InvoiceNinja are stored inside the folder **userdata** and in the **docker-compose.yml**. If you copy this folder to a any different location, you have a backup. I recommend to zip/compress the folder additionally. Let's do it:

  - If Invoiceninja is running, stop it by executing `instop`.
  - With your terminal, navigate to your invoiceninja folder and run there (you might need 'sudo' in advance):
    ```
    cp docker-compose.yml userdata/
    tar cfvz DATE-invoiceninja-backup.tar.gz userdata/
    ```
    Then, you should have a new file `DATE-invoiceninja-backup.tar.gz`. This is your complete backup.
    Note that the backup/restore options inside InvoiceNinja do not cover all your user data and settings.

- **Restore**:

  - If Invoiceninja is running, stop it by executing `instop`.
  - With your terminal, navigate to your invoiceninja folder and delete your existing userdata:
    ```
    sudo rm -rf userdata/
    ```
  - Copy your Backup (=folder "userdata" in a compressed/zipped version) into the invoiceninja folder and uncompress/unzip it here, such that there is a folder "userdata" next to the docker-compose file:
    ```
    sudo tar xfvz DATE-invoiceninja-backup.tar.gz
    sudo cp userdata/docker-compose.yml .
    ```
  - That's it! Start invoiceninja again to check if everything was restored correctly.


Update
-------------
To do a safe update, go to the [release page](https://github.com/MathiasRenner/invoiceninja-docker/releases) and follow the instructions in the sections "How to upgrade from previous version" – for all versions newer than the one you use right now. You can always backup, deinstall and reinstall the "whole" thing, which might be faster than updating it from release to release.

You can always try to do the update as follows, but this is not very safe (it might break your invoice ninja, but never deletes any of your data):
```
docker pull invoiceninja/invoiceninja
```
That's all! Now run `instop` and `instart` and then enjoy InvoiceNinja in its latest version.


Deinstall
--------------
- With the terminal, navigate to somewhere outside of the invoiceninja folder
- Completely uninstall InvoiceNinja with the following command:
```
curl -s https://raw.githubusercontent.com/MathiasRenner/invoiceninja-docker/master/Deinstall.sh -o Deinstall.sh && bash Deinstall.sh
```


Troublehooting
-------------
- **"Bad Gateway"**: If you see a "Bad Gateway" in your browser instead of the InvoiceNinja interface, wait some seconds and try again. The service might need some more time to get up and running. If the error remains, start the clean up task that is also included in this project by simply running `inclean`. If the error still persists afterwards, run `docker rm -fv $(docker ps -aq) && instart`.  *Note* that this command removes all containers and volumes on your machine!
- **"Cannot connect to the Docker daemon"**: Make sure you have added your Linux user to the Docker group as described in the Docker docs. On Ubuntu, this issue is fixed by `sudo usermod -aG docker $USER`
- **"Whoops, looks like something went wrong"**: This error might result from an docker image update without getting the latest version of this repository, e.g. the latest docker-compose file. In this case, try to identify the changes (in commits) between your version and the version from the repo here ([check the realease page for changes](https://github.com/MathiasRenner/invoiceninja-docker/releases)), or backup, deinstall and install invoiceninja again following the instructions above.
- **Error: Update your API Key...**: You can ignore this since you use InvoiceNinja locally. To fix this, go to the folder with the `docker-compose.yml` file and run: `docker-compose exec app php artisan ninja:update-key`. That's it.

Support this project
-------------
If you want this project to get better, support me with a few cents:

<a href="https://liberapay.com/Bitleaf/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a>


License
-----------

![](https://www.gnu.org/graphics/gplv3-127x51.png)

The project is licensed unter the GPLv3.

Copyright (C) Mathias Renner

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

See <http://www.gnu.org/licenses/> fore more information.
