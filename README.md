# utilities
Useful reusable scripts and code snippets

## Bash
### keep-process-running
Starts a process and restarts it as soon as it stops running

### tar-file-xz
Compress a file as tar.xz and then (on success) deletes the file

## Docker
### Debian-base
Updated debian image, with pre-installed package sets

USAGE:  
`docker build -f Dockerfile-debian-base -t fedfranz/debian-base .`
- Select package set (`pkg_set`):  
`docker build -f Dockerfile-debian-base -t fedfranz/debian-base:SETNAME --build-arg pkg_set=SETNAME .`

Available sets:  
- curl wget
- ping
- ifconfig
- nslookup

NOTE:  
- To update to latest version use '--no-cache' option
