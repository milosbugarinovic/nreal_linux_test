xhost +SI:localuser:root
docker compose run --rm -it nreal /bin/bash -c "python3 ./src/main.py"
xhost -SI:localuser:root
