#!/usr/bin/env bash

# for preparing host to run nvidia docker, see academic-budge-bert/setup_host_to_run_nvidia_container.md


sudo docker run \
    -it --rm \
    -v /home/hua/DinkyTrain/:/DinkyTrain \
    --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864  \
    nvcr.io/nvidia/pytorch:22.04-py3

# but I am not able to install DinkyTrain (which pulls torch from pip and uninstalls nvidia's custom built torch ...)
# both torch are 1.12 :(

