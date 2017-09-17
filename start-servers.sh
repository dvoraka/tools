#!/usr/bin/env bash
#
# Starts all development Docker containers with the "docker-compose up" command.
#
# It uses Python virtual environment because of docker-compose installation.
#
# version 0.1
#

# the Python virtual environment name with installed docker-compose command
ENV=docker
# the root of all virtual environments
VIRT_ENVS=~/.virtenvs
# the project name
PROJECT_NAME=NAME
# the root of the project sources
PROJECT_DIR=~/projects/${PROJECT_NAME}


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
    source ${VIRT_ENVS}/${ENV}/bin/activate

    cd ${PROJECT_DIR}/docker/

    # start containers
    docker-compose up
}

# start
before
start
after
