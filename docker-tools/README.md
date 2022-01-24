Toolbox

This is a Docker container which contains the below tools 

* aws cli
* Terraform
* Ansible

How to get: 

First build container 
```
docker build -t toolbox .
```
Run container 
```
docker run -it --rm toolbox bash
```
OR 

```
./toolbox.sh
```
