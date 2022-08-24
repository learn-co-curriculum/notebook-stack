# Docker Container Specification for `learn-env`

## Setup Instructions (macOS)

You do **not** need to clone this repo locally if you only want to run the code. Cloning the repo is useful if you want to make changes to the image specifications (`Dockerfile`, etc.) only.

### Docker Installation

Install Docker Desktop by selecting your OS and chip type (Intel or Apple) and following the instructions on the [Get Docker](https://docs.docker.com/get-docker/) page.

You don't need to log in to DockerHub to complete these setup steps, although you can if you want to.

### Building the Image

This repo has _specifications_ for a docker image and does not contain the image itself. You have to build the image before you can run it.

(It's kind of like source code vs. executable if you've ever worked in a compiled language before.)

In the terminal (any directory should work), check to ensure that `docker` is in your path:

```bash
which docker
```

If that prints out a path, that means it worked. If it doesn't, that means you need to restart your terminal or potentially troubleshoot the docker installation from the previous step.

If the previous step worked, run this command in the terminal (any directory should work) to build the image. It will create a file that takes up a couple of gigabytes on disk. The build process involves downloading different files to install from GitHub and elsewhere and therefore requires internet access.

```bash
docker build https://github.com/learn-co-curriculum/notebook-stack.git
```

If you are working on modifying the Docker stack itself (e.g. modifying the Dockerfile) then it is not necessary to push changes to GitHub prior to actually building the image. Instead you can navigate to the root of the `notebook-stack` directory and simply run `docker build .` (the `.` at the end is necessary to indicate that the build should be based on everything in the current directory).

### Running the Image / Creating a Container

When you use the `docker run` command it uses the image to create a container. (If you want, you can have multiple containers based on the same image at a time.)

To create a container you need to determine the ID of the image you want to use. You can either do this by clicking on the "Images" menu option in Docker Desktop, or by typing this command in the terminal (any directory should work) to view a list of images:

```bash
docker images
```

When you have found the ID, copy it so you can use it in the following command:

```bash
docker run --rm --publish 8888:8888 --platform linux/amd64 <IMAGE ID>
```

For example, if your image ID were `76d0a7642434`, the command would be:

```bash
docker run --rm --publish 8888:8888 --platform linux/amd64 76d0a7642434
```

Note that this assumes you are not currently running Jupyter Notebook on port 8888, and "publishes" the container port to your computer's port. Unlike if you just ran `jupyter notebook` in the terminal, this will run into issues if that port is already in use. You can try changing the first `8888` to a different number if it's not feasible to shut down currently-running notebook servers.

The container will run a jupyter notebook server as soon as it is started. You'll need to copy the URL starting with `http://127.0.0.1` into your browser to interact with the server (replacing `8888` with a different port if you are using a different one).

When you are done running the container, type control-C in the terminal. The Docker Desktop app is also helpful for looking at and/or stopping all of the existing containers if you accidentally close the terminal window or otherwise just want to use a graphical interface.

### Connecting to a Local File System

By default this image has its own internal file system that is not connected to your computer's file system. You need to mount your computer's file system volume if you want to have access to it in the container.

This time it _does_ matter what directory you run the code from. The directory you are in when you run this command from the terminal will become the "work" directory in the container:

```bash
docker run --rm --publish 8888:8888 --platform linux/amd64 --volume $(pwd):/home/jovyan/work <IMAGE ID>
```
