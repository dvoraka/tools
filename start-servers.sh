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
ENV_DIR="${VIRT_ENVS}/${ENV}"
# the project name
PROJECT_NAME=NAME
# the root of the project sources
PROJECT_DIR="~/projects/${PROJECT_NAME}"
# docker-compose command
DC_CMD=docker-compose


function before {
    echo ' * Starting servers...'
    # other before tasks
}

function after {
    # other after tasks
    echo 'Done.'
}

function start {
    # check virtual environment
    check_virtual_env
    # activate the virtual environment
    source "${ENV_DIR}/bin/activate" || exit 1

    # switch to the directory with a configuration
    cd "${PROJECT_DIR}/docker/" || exit 1

    # check docker-compose
    check_docker_compose_cmd
    # start containers
    docker-compose up
}

function install_docker_compose {
    echo " * Installing ${DC_CMD}..."
    pip install "${DC_CMD}"
    echo "Done."
}

function check_docker_compose_cmd {
    if ! [ -x "$(command -v ${DC_CMD})" ]
    then
        echo "${DC_CMD} is not installed!"
        install_docker_compose
    fi
}

function check_virtualenv_cmd {
    if ! [ -x "$(command -v virtualenv)" ]
    then
        echo "virtualenv is not installed!"
        echo "You need to install virtualenv package."
        return 1
    fi
}

function create_virtual_env_dir {
    echo " * Creating virtual env ${ENV_DIR}..."
    check_virtualenv_cmd || exit 1
    virtualenv "${ENV_DIR}"
    echo "Done."
}

function check_virtual_env {
    if ! [ -d "${ENV_DIR}" ]
    then
        echo "Virtual env directory does not exist!"
        create_virtual_env_dir
    fi
}


# start
before
start
after
