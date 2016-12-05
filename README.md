# invoiceninja-docker for localhost
This project simplifies the usage of [invoiceninja](https://github.com/invoiceninja/invoiceninja) leveraging [Docker](http://docker.com/) while maintaining a high level of security.

Invoiceninja is a great tool for business owners to process invoices. However it's implemented as a webservice, which could expose clients' data to the Internet in case of security issues. Since security issues are not unlikely, this project avoids security problems by running invoiceninja only on localhost.

**Note that this is still beta quality and not for production use yet!**

Benefits of this setup
-----------
- Invoiceninja will run only on localhost, and be accessible only from localhost.
- Invoiceninja can be started and stopped when needed within milliseconds.
- Invoiceninja will be able to send emails and invoices as long localhost is connected to the Internet.
- Backups are as easy as copying one folder.


Drawbacks
------------
- The client portal of invoiceninja will not work since it runs on localhost. In the portal, clients can see their invoices and download them. This is more secure than sending invoices via email, but a compromise of this setup.


How to setup
---------------
- Setup `docker` and `docker-compose` following Docker's official docs. Make sure you have `docker-compose` version >= 1.6. Also make sure you have `git` installed.
- Download the `docker-compose.yml` from this repository by running

  ```
  git@github.com:MathiasRenner/invoiceninja-docker.git
  ```
- Change into the cloned directory with 

  ```
  cd invoiceninja-docker
  ```
  
- Next, pull the necessary files to your machine by running

  ```
  docker-compose pull
  ```
- When this has been finished, run

  ```
  docker-compose up -d
  ```
- Now, you should see 4 new containers running when executing `docker ps`. In that case invoiceninja is up and running.
- Now, let's open it in Firefox. Run

  ```
  docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' invoiceninja-docker_web_1 | awk '{print "http://"$1}' | xargs xdg-open >> /dev/null &
  ```
- Congrats! Your local instance of invoiceninja is running! See the next section to see how to start and stop it.


How to start and stop it
--------------

### Start invoiceninja
- Make sure you are in the same repository where the `docker-compose.yml` resides and run

  ```
  docker-compose up -d
  ```

- Open invoiceninja in firefox with

  ```
  docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' invoiceninja-docker_web_1 | awk '{print "http://"$1}' | xargs xdg-open >> /dev/null &
  ```

### Stop invoiceninja
Make sure you are in the same repository where the `docker-compose.yml` resides and run
  ```
  docker-compose down
  ```

Instead of `up -d` and `down`, you can also use `unpause` and `pause`.


Backup
-----
All settings are stored in the database, which resides in the folder `database`. If you copy this folder to a any different location, you have a backup.


Troublehooting
-------------
- If you see a "Bad Gateway" in your browser instead of invoice ninja, wait some seconds and try again. If the error remains, a clean up with the following command probably resolves the problem: `docker rm -fv $(docker ps -aq)`.  *Note* that this command removes all containers and volumes on your machine!


TODOs
------------
- Automate start & stop with shell alias
- Hide output of "xargs firefox >>/dev/null &" better
