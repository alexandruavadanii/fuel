#!/bin/bash -e
##############################################################################
# Copyright (c) 2018 Mirantis Inc., Enea AB and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

OPNFV_FUEL_DIR="/root/fuel"

if [ ! -z $SALT_EXT_PILLAR ]; then
    cp -avr /tmp/${SALT_EXT_PILLAR}.conf /etc/salt/master.d/
fi

### FIXME: only yml files?
rm -rf "/srv/salt/reclass/nodes" "/srv/salt/reclass/classes/cluster" "/srv/salt/reclass/classes/system"
cp -avr "${OPNFV_FUEL_DIR}/mcp/reclass/nodes" "/srv/salt/reclass/nodes"
cp -avr "${OPNFV_FUEL_DIR}/mcp/reclass/classes/cluster" "/srv/salt/reclass/classes/cluster"
cp -avr "${OPNFV_FUEL_DIR}/mcp/reclass/classes/system" "/srv/salt/reclass/classes/system"
cp -avr "${OPNFV_FUEL_DIR}/mcp/scripts/mcp.rsa" "/root/fuel/mcp.rsa"
cp -avr "/root/pod_config.yml" "/srv/salt/reclass/classes/cluster/all-mcp-arch-common/opnfv/pod_config.yml"

rm -f ${OPNFV_FUEL_DIR}/mcp/salt-formulas/*/.git
cp -avr ${OPNFV_FUEL_DIR}/mcp/salt-formulas/* /srv/salt/formula/salt-formulas/
ln -sf ${OPNFV_FUEL_DIR}/mcp/salt-formulas/salt-formula-opendaylight/* /srv/salt/env/prd/
ln -sf ${OPNFV_FUEL_DIR}/mcp/salt-formulas/salt-formula-tacker/* /srv/salt/env/prd/

ln -sf /srv/salt/formula/salt-formulas/salt-formula-opendaylight/metadata/service \
       /srv/salt/reclass/classes/service/opendaylight
ln -sf /srv/salt/formula/salt-formulas/salt-formula-tacker/metadata/service \
       /srv/salt/reclass/classes/service/tacker

### FIXME
sed -i -e "s|return 'start/running' in |return 'is running' in |" \
       -e "s|ret = _default_runlevel|return _default_runlevel|" \
    /usr/lib/python2.7/dist-packages/salt/modules/upstart.py

### FIXME
sudo chown salt:salt -R /srv/salt

if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
    exec /usr/bin/salt-master --log-file-level=quiet --log-level=info "$@"
else
    exec "$@"
fi
