# nextcloud-ocdownloader-deps-dockerfile
The Dockerfile that adds ocdownloader's dependencies to the official nextcloud image.  

Code originally from https://github.com/frontc/docker, I extracted the essentials and used a yet different and better approach to patch the original image (using `FROM nextcloud` in Dockerfile instead of editing directly in the `nextcloud` Dockerfile). All credits to [frontc](https://github.com/frontc).

# Usage
I recommend using *docker-compose*, though.
```
$ git clone https://github.com/BirkhoffLee/nextcloud-ocdownloader-deps-dockerfile.git
$ cd nextcloud-ocdownloader-deps-dockerfile
$ docker build -t nextcloud_patched .
$ docker run ... nextcloud_patched
```

After installation of ocdownloader, choose `Aria2` for the downloader option (should be default).

# Credit
All credits to https://github.com/frontc/docker, thanks for the work.
