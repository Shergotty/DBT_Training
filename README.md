# run 

if you are using this repository on windows and you have not installed make and or [scoop](https://scoop.sh/), you can do so by:

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

install scoop via shell

```sh
scoop install make
```

## Docker comopose

make sure you have installed (if on windows) docker and initilized the windows subsystem for linux

initilize and install wsl
```ps1
wsl
```
choose an OS variant of your choice

### container setup

either run

```sh
docker compose up -d
```

for initilizing the contianer 

and 

```sh
docker compose down -v
```

to stop and delete your container

alternativly use

```sh
make up
```
or
```sh
make down
```

respectiveley

to start python run 
`powershell`
```ps1
.\shell.ps1
```
`shell`
or 
```sh
.\shell.sh
```
alternativly use
`powershell`
```ps1
make ps1
```
or
`shell`
```sh
make sh
```
respectiveley

to setup your docs run

```sh
dbt docs generate
```

and

```sh
dbt docs serve --host 0.0.0.0 --port 8080
```
