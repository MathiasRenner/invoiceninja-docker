# Using InvoiceNinja with high security and usability on localhost

InvoiceNinja is a great tool for business owners to process invoices. However it's implemented as a web service, which could expose clients' data to the Internet in case of security issues. Since security issues are not unlikely, this project avoids security problems by running InvoiceNinja only on localhost.

This project simplifies the usage of [InvoiceNinja](https://github.com/invoiceninja/invoiceninja) leveraging [Docker](http://docker.com/) while maintaining a high level of security.

The project has been successfully tested on Ubuntu. Other Linux based operating systems require adjustments to work fine.


Benefits of this setup
-----------
- **Security:** InvoiceNinja will run only on localhost without being accessible from any other machine.
- **Usability:**
  - InvoiceNinja can be started and stopped when needed within milliseconds.
  - Backups are as easy as copying one folder.
- **Updates**: You can always update within a single command – it's safe and fast.
 
 
Drawbacks of this setup
------------
InvoiceNinja will even be able to send emails and (single) invoices as long as localhost is connected to the Internet. Still, there are two things that won't not work:
  - The **client portal** of InvoiceNinja will not be accessible by clients, since it runs on localhost without being accessible from any other machine. In the portal, clients can see their invoices and download them. This is more secure than sending invoices via email, but a compromise of this setup.
  - **Recurring invoices**, e.g. for monthly invoices for some maintenance contract, cannot be sent out regularly since InvoiceNinja is not constantly running as a daemon in this setup.


Easy Setup
---------------
Prerequisites:
  - Setup `docker` and `docker-compose` following Docker's official docs. Make sure you have `docker-compose` version >= 1.6.
  - Make sure you can run `docker` commands without *sudo*. If you get an error like `Got permission denied` when running e.g. `docker ps`, [follow these instructions here](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo).
  - Make sure you have `git` installed.

You can install everything with just the following command. *Note:* You want to run the command inside a folder where InvoiceNinja should be downloaded to.

```
curl -s https://raw.githubusercontent.com/MathiasRenner/invoiceninja-docker/master/Easy-Setup.sh | bash
```

If you prefer a step-by-step installation, follow the [manual setup instructions](https://github.com/MathiasRenner/invoiceninja-docker/blob/master/MANUAL-SETUP.md).


Start & stop
--------------
- To start InvoiceNinja, just run `instart`
- To stop it: `instop`


Backup & Restore
----------------
- **Backup**: All settings for InvoiceNinja are stored inside the folder **userdata**. If you copy this folder to a any different location, you have a backup. I recommend to zip/compress the folder additionally. Let's do it:

  - If Invoiceninja is running, stop it by executing `instop`.
  - With your terminal, navigate to your invoiceninja folder and run there:
    ```
    sudo tar cfvz DATE-invoiceninja-backup.tar.gz userdata/
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
    ```
  - That's it! Start invoiceninja again to check if everything was restored correctly.


Update
-------------
To update, simply run
```
docker pull invoiceninja/invoiceninja
```
That's all! You can now run `instart` and use InvoiceNinja in its latest version.


Troublehooting
-------------
- **Bad Gateway**: If you see a "Bad Gateway" in your browser instead of the InvoiceNinja interface, wait some seconds and try again. The service might need some more time to get up and running. If the error remains, start the clean up task that is also included in this project by simply running `inclean`. If the error still persists afterwards, run `docker rm -fv $(docker ps -aq) && instart`.  *Note* that this command removes all containers and volumes on your machine!
- **Cannot connect to the Docker daemon.** Make sure you have added your Linux user to the Docker group as described in the Docker docs. On Ubuntu, this issue is fixed by `sudo usermod -aG docker $USER`
