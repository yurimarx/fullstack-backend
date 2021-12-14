## fullstack-backend-rest-application
This is a sample of a REST API application built with ObjectScript in InterSystems IRIS.
It also has OPEN API spec, 
can be developed with Docker and VSCode,
can ve deployed as ZPM module.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation with ZPM

zpm:USER>install fullstack-backend

## Installation for development

Clone/git pull the repo into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):
```
$ git clone git@github.com:yurimarx/fullstack-backend.git
```
Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```
## How to Work With it

This project creates /fullstack-backend REST web-application on IRIS which implements 4 types of communication: GET, POST, PUT and DELETE aka CRUD operations for a Movie Catalog.

Open http://localhost:52773/swagger-ui/index.html to test the REST API

Replace swagger defaolt Open API 2.0 documentation *http://localhost:52773/fullstack-backend/_spec* by:
```
http://localhost:52773/fullstack-backend/_spec
```
This REST API exposes two GET requests: all the data and one record.
To get all the data in JSON call:
```
http://localhost:52773/fullstack-backend/castings
```
To request the data for a particular record provide the id in GET request like 'http://localhost:52773/fullstack-backend/castings/id' . E.g.:
```
http://localhost:52773/fullstack-backend/castings/1
```
This will return JSON data for the casting with ID=1, something like that:
```
{
        "castingId": 1,
        "movie": "1",
        "actor": "2",
        "characterName": "Lucia"
}
```
### Testing POST request
Create a POST request e.g. in Postman with raw data in JSON. e.g.
```
{
        "movie": "1",
        "actor": "2",
        "characterName": "Lucia"
}
```
Adjust the authorisation if needed - it is basic for container with default login and password for    
IRIS Community edition container and send the POST request to 'http://localhost:52773/fullstack-backend/castings'

This will create a record in dc.movie.model.Casting class of IRIS.

### Testing PUT request
PUT request could be used to update the records. This needs to send the similar JSON as in POST request above supplying the id of the updated record in URL.
E.g. we want to change the record with id=1. Prepare in Postman the JSON in raw like following:

```
    {
        "movie": "1",
        "actor": "2",
        "characterName": "Lucia Gimenez"
    }
```

and send the put request to:
```
http://localhost:52773/fullstack-backend/castings/1
```

### Testing DELETE request

For delete request this REST API expects only the id of the record to delete. E.g. if the id=1 the following DELETE call will delete the record:

```
http://localhost:52773/fullstack-backend/castings/1
```

## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.

The script in Installer.cls will import everything you place under /src/cls into IRIS.

## What's insde the repo
### Dockerfile
The simplest dockerfile to start IRIS and load ObjectScript from /src/cls folder
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.
### .vscode/settings.json
Settings file to let you immedeately code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))   
### .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript
