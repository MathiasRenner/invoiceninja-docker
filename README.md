# Using InvoiceNinja with high security and usability on localhost
This project simplifies the usage of [InvoiceNinja](https://github.com/invoiceninja/invoiceninja) leveraging [Docker](http://docker.com/) while maintaining a high level of security.

InvoiceNinja is a great tool for business owners to process invoices. However it's implemented as a webservice, which could expose clients' data to the Internet in case of security issues. Since security issues are not unlikely, this project avoids security problems by running InvoiceNinja only on localhost.

**Note that this is still beta quality and not for production use yet!**

Benefits of this setup
-----------
- **Security:** InvoiceNinja will run only on localhost without being accessible from any other machine.
- **Usability:**
  - InvoiceNinja can be started and stopped when needed within milliseconds.
  - Backups are as easy as copying one folder.


The drawback
------------
InvoiceNinja will even be able to send emails and invoices as long localhost is connected to the Internet. **Only the client portal of InvoiceNinja will not work** since it runs on localhost without being accessible from any other machine. In the portal, clients can see their invoices and download them. This is more secure than sending invoices via email, but a compromise of this setup.


Prerequisites
---------------
- Setup `docker` and `docker-compose` following Docker's official docs. Make sure you have `docker-compose` version >= 1.6.
- Make sure you have `git` installed.

Easy Setup
---------------
You can install everything with just the following command:

```
curl -s https://gist.githubusercontent.com/MathiasRenner/69e6bbb274e5e6a8b759cb7e21f20b9f/raw/91784ac3a1082dae83f9e5f6580645af63dc846d/install.sh | bash
```

If you prefer a step-by-step installation, follow the [manual setup instructions](https://github.com/MathiasRenner/invoiceninja-docker/blob/master/MANUAL-SETUP.md).


Start & stop
--------------
- To start InvoiceNinja, just run `instart`
- To stop it: `instop`


Backup & Restore
----------------
- Backup: All settings for InvoiceNinja are stored in the database, which resides in the folder `invoiceninja-docker/database`. If you copy this folder to a any different location, you have a backup.
- Restore: The only way to restore all settings is to restore the folder `database` – which is easy and fast. The backup/restore options inside InvoiceNinja don't cover all settings.


Troublehooting
-------------
- **Bad Gateway**: If you see a "Bad Gateway" in your browser instead of the InvoiceNinja interface, wait some seconds and try again. The service might need some more time to be up and running. If the error remains, a clean up with the following command probably resolves the problem: `docker rm -fv $(docker ps -aq)`.  *Note* that this command removes all containers and volumes on your machine!
