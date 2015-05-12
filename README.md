# docker-node-easy
Dockerfile for building an easy-to-use NodeJs docker container.


## Features

* No rebuilds necessary when only the application code changed and not the package.json file.
* The docker-node-easy images are mainly intended for development and testing purposes.
* Based on debian:wheezy.
* Most NodeJs packages should be able to be built from scratch, because Debian's build-essential packages are installed.


## How to use
* Make sure that the `package.json` file of your NodeJs project contains a `main` entry.
* In your NodeJs project's root directory (there where the `package.json` file is), create a file called `Dockerfile` and add one line to it (NOTE: change `<version>` to the required version tag, e.g. '0.1'):
```
FROM tbknl/docker-node-easy:<version>
```
* You can of course add more lines to the dockerfile, for example to expose a network port or add an environment variable.
* Assuming that your docker daemon is running, run (from your project's root directory):
```
docker build -t <your_project_name> .
```
* Now run your NodeJs program as follows:
```
docker run -v $(pwd):/var/app/src <your_project_name> <arguments>
```

Note that the arguments to your node application are directly supplied to the docker-run command. That is because the entrypoint for the node application is already set in the dockerfile. If you want to run a different command on the docker container, then use `docker run --entrypoint <command> ...` instead.

Rebuilding the docker-node-easy image is only necessary when the `package.json` file changes, most notably the list of dependency packages. Changes in the application code do not need a rebuild of the docker image. But because docker reuses cached images when building, you can run the docker-build command every time before running the docker-run command.

