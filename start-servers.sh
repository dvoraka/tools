#!/usr/bin/env bash
#
# Starts all development Docker containers with the "docker-compose up" command.
#
# It uses Python virtual environment because of docker-compose installation.
#
# version 0.2-SNAPSHOT
#

# the Python virtual environment name with installed docker-compose command
ENV=docker
# the root of all virtual environments
VIRT_ENVS=~/.virtenvs
# virtual name directory
ENV_DIR=${VIRT_ENVS}/${ENV}
# the project name
PROJECT_NAME=NAME
# the root of the project sources
PROJECT_DIR=~/projects/${PROJECT_NAME}
# docker-compose command
DC_CMD=docker-compose


function before {
    echo 'Starting servers...'
    # other before tasks
}

function after {
    # other after tasks
    echo 'Done.'
}

function start {
    # activate the virtual environment
    source ${ENV_DIR}/bin/activate

    cd ${PROJECT_DIR}/docker/

    # start containers
    docker-compose up
}

function check_docker_compose {

    if ! [ -x "$(command -v docker-compose)" ]
    then
        echo "docker-compose is not installed!"
    fi
}

function check_virtual_env {

    if ! [ -d ${ENV_DIR}/ ]
    then
        echo "Virtual env directory does not exist!"
    fi
}

# start
before
start
after
