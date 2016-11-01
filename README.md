# invoiceninja-docker for localhost
This project simplifies the usage of [invoiceninja](https://github.com/invoiceninja/invoiceninja) leveraging [Docker](http://docker.com/) while maintaining a high level of security. 

Invoiceninja is a great tool for business owners to process invoices. However it's implemented as a webservice, which could expose clients' data to the Internet in case of security issues. Since security issues are not unlikely, this project avoids security problems by running invoiceninja only on localhost.

**Note that this is still beta quality and not for production use yet!**

Benefits of this setup
-----------
- Invoiceninja will run only on localhost, and accessible only from localhost.
- Invoiceninja can be started and stopped when needed within seconds.
- Invoiceninja will be able to send emails as long localhost is connected to the Internet.


Drawbacks
------------
- The client portal of invoiceninja will not work since it runs on localhost. In the portal, clients can see their invoices and download them. This is more secure than sending invoices via email, but a compromise of this setup.


How to setup
---------------
- Setup `docker` and `docker-compose` following Docker's official docs
- Download the `docker-compose.yml` from this repository by running
```
wget -O docker-compose.yml https://raw.githubusercontent.com/MathiasRenner/invoiceninja-docker/master/docker-compose.yml?token=ACRG-IF8QjuVQVB_w2tcr-cNlmr2NW96ks5YIddewA%3D%3D
```
- Next, pull the necessary files to your machine by running
```
docker-compose up
```
- When all images have been pulled, press `STRG + C` to cancel the docker-compose deployment. When this has been finished, run
```
docker-compose up -d
```
- Now, you should see 4 new containers running when executing `docker ps`. In that case invoiceninja is up and running.
- Now, let's open it in Firefox. Run `docker ps` and copy the `CONTAINER ID` of the container with the name `invoiceninja-docker_web_1`. Insert the copied `CONTAINER ID` into the following command and run it.
```
docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  <CONTAINER ID> | awk '{print "http://"$1}' | xargs xdg-open >> /dev/null &
```
- Congrats! Your local instance of invoiceninja is running! See the next section to see how to start and stop it.

Usage
--------------

### Start invoiceninja
- Make sure you are in the same repository where the `docker-compose.yml` resides and run

```
docker-compose unpause
```
- Run `docker ps` and copy the `CONTAINER ID` of the container with the name `invoiceninja-docker_web_1`
- `docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  <CONTAINER ID>`

- Open invoiceninja in firefox with
```
docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <CONTAINER ID> | xargs firefox >>/dev/null &
```

### Stop invoiceninja
Make sure you are in the same repository where the `docker-compose.yml` resides and run
```
docker-compose pause
```

TODOs
------------
- Automate start & stop with scripts
- Implement/automate backup functionality
- Test import/export functions, see https://github.com/invoiceninja/invoiceninja/issues/1126
