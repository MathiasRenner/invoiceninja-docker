Manual Setup
---------------
- Clone this repo to your machine:

  ```
  git clone git@github.com:MathiasRenner/invoiceninja-docker.git
  ```
- Change into the cloned directory with

  ```
  cd invoiceninja-docker
  ```

- When this has been finished download the necessary files and start InvoiceNinja with

  ```
  docker-compose up -d
  ```
  If everything was successful, the output of the previous command looks similar to this:

  ```
  Creating invoiceninjadocker_db_1
  Creating invoiceninjadocker_app_1
  Creating invoiceninjadocker_web_1
  ```

- Now, open InvoiceNinja in Firefox at `http://localhost:8080/`. Congrats! At first, you might see a "Bad Gateway". In this case, grant the system about 10 seconds more to start up. Then, your local instance of InvoiceNinja should be up and running!

- Finally, run the following lines to simplify starting and stopping InvoiceNinja:

  ```
  echo "alias instart='docker-compose -f $(pwd)/docker-compose.yml up -d && xdg-open http://localhost:8080/'" >> ~/.bashrc
  echo "alias instop='docker-compose -f $(pwd)/docker-compose.yml stop'" >> ~/.bashrc
  source ~/.bashrc
  ```
