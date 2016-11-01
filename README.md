# invoiceninja-docker for localhost
This project simpflifies the usage of [invoiceninja](https://github.com/invoiceninja/invoiceninja) leveraging [Docker](http://docker.com/) while maintaining a high level of security. 

Invoiceninja is a great tool for business owners to process invoices. However it's implemented as a webservice, which could exposes clients' data to the Internet in case of security issues. Since security issues are not unlikely, this project avoids security problems by running invoiceninja on localhost.

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
- Download the `docker-compose.yml` from this repository
```
wget https://raw.githubusercontent.com/MathiasRenner/invoiceninja-docker/master/docker-compose.yml?token=ACRG-IF8QjuVQVB_w2tcr-cNlmr2NW96ks5YIddewA%3D%3D
```
- Make sure you are in the same repository where the resides and run
```
docker-compose up
```


Usage
--------------

### Stop invoiceninja

```
docker-compose pause
```

### Start invoiceninja
- Unpause invoiceninja with
```
docker-compose unpause
```
- Run `docker ps` and copy the `CONTAINER ID` of the container with the NAME `invoiceninja-docker_web_1`
- `docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  5b8380f7d5e9`

- Open invoiceninja in firefox with
```
docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 58a2d7bcd4ac | xargs firefox >>/dev/null &
```


TODOs
------------
- Automate start & stop with scripts
- Implement/automate backup functionality
- Test import/export functions, see https://github.com/invoiceninja/invoiceninja/issues/1126
