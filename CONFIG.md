#Contact form:
This project is running under symfony 6 and PHP 8.1

## Installing the project locally:
* we need to run docker-compose to install the database
```bash
    docker-compose up -d
```
* run symfony server, to need to install [Symfony CLI](https://symfony.com/download)
```bash
    symfony serve -d
```
* init the project data
```bash
#   for dev environment
    make install env=dev 
#   or
#   for test environment
    make install env=test
```

PS: you can check the makefile to see all available commands 