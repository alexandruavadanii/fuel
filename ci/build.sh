#!/bin/bash -e
# shellcheck disable=SC2034,SC2154,SC1090,SC1091,SC2155
##############################################################################
# Copyright (c) 2018 Ericsson AB, Mirantis Inc., Enea AB and others.
# jonas.bjurel@ericsson.com
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

##############################################################################
# BEGIN of Exit handlers
#
do_exit () {
    local RC=$?
    if [ ${RC} -eq 0 ]; then
        notify_n "[OK] MCP: Docker build finished succesfully!" 2
    else
        notify_n "[ERROR] MCP: Docker build threw a fatal error!"
    fi
}
#
# End of Exit handlers
##############################################################################

##############################################################################
# BEGIN of variables to customize
#
CI_DEBUG=${CI_DEBUG:-0}; [[ "${CI_DEBUG}" =~ (false|0) ]] || set -x
MCP_REPO_ROOT_PATH=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
DEPLOY_DIR=$(cd "${MCP_REPO_ROOT_PATH}/mcp/scripts"; pwd)
DOCKER_DIR=$(cd "${MCP_REPO_ROOT_PATH}/docker"; pwd)

source "${DEPLOY_DIR}/globals.sh"

#
# END of variables to customize
##############################################################################

##############################################################################
# BEGIN of main
#

# Enable the automatic exit trap
trap do_exit SIGINT SIGTERM EXIT

# Set no restrictive umask so that Jenkins can remove any residuals
umask 0000

pushd "${DOCKER_DIR}" > /dev/null

# FIXME: install docker, pip, pipenv etc, pyinvoke, dockermake
# NOTE: do not include reclass yet, it will be moved from runtime inject here later
# NOTE: no push
pipenv --two
pipenv install
pipenv shell \
  'invoke build saltmaster \
    --require "salt salt-formulas tini-saltmaster" \
    --dist=ubuntu \
    --dist-rel=xenial \
    --formula-rev=nightly \
    --salt=2017.7; \
  exit'

popd > /dev/null

#
# END of main
##############################################################################
