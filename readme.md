# damon/ssh

This is just a simple container which runs SSH. The only user by default
is `root`, and the password is set to `root`.

On the docker index: https://index.docker.io/u/damon/ssh
On github: https://github.com/blackrobot/docker-ssh

## To Run It

1. Run the container, publishing port 22 to your host:

    ```bash
    $ SSH_ID=$(docker run -id -p 22 damon/ssh)
    ```

2. Log into the container via `ssh`, using `root` as the password when
   prompted:

    ```bash
    $ ssh root@127.0.0.1 -p "$(docker port $SSH_ID 22 | cut -d ':' -f 2)"
    ```
