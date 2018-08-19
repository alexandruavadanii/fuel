#!/bin/bash -e
##############################################################################
# Copyright (c) 2017 Mirantis Inc., Enea AB and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

if [ ! -z $SALT_EXT_PILLAR ]; then
    cp -avr /tmp/${SALT_EXT_PILLAR}.conf /etc/salt/master.d/
fi;

###OPNFV_GIT_DIR="/root/opnfv"
OPNFV_FUEL_DIR="/root/fuel" # Should be in sync with patch.sh, scripts patches

# wtf: FIXME: only yml files
rm -rf "/srv/salt/reclass/nodes" "/srv/salt/reclass/classes/cluster" "/srv/salt/reclass/classes/system"
cp -avr "${OPNFV_FUEL_DIR}/mcp/reclass/nodes" "/srv/salt/reclass/nodes"
cp -avr "${OPNFV_FUEL_DIR}/mcp/reclass/classes/cluster" "/srv/salt/reclass/classes/cluster"
cp -avr "${OPNFV_FUEL_DIR}/mcp/reclass/classes/system" "/srv/salt/reclass/classes/system"
cp -avr "${OPNFV_FUEL_DIR}/mcp/scripts/mcp.rsa" "/root/fuel/mcp.rsa"
cp -avr "/root/pod_config.yml" "/srv/salt/reclass/classes/cluster/all-mcp-arch-common/opnfv/pod_config.yml"

#?CI_DEBUG=${CI_DEBUG:-0}; [[ "${CI_DEBUG}" =~ (false|0) ]] || set -x
#F_GIT_ROOT=$(git rev-parse --show-toplevel)
#F_GIT_DIR=$(cd "${F_GIT_ROOT}/mcp" && git rev-parse --git-dir)
#F_GIT_SUBD=${F_GIT_ROOT#${F_GIT_DIR%%/.git*}}
####OPNFV_TMP_DIR="/home/${SALT_MASTER_USER}/opnfv"
#OPNFV_RDIR="reclass/classes/cluster/all-mcp-arch-common"
####OPNFV_VCP_IMG="mcp/scripts/base_image_opnfv_fuel_vcp.img"
####OPNFV_VCP_DIR="/srv/salt/env/prd/salt/files/control/images"
####LOCAL_GIT_DIR="${F_GIT_ROOT%${F_GIT_SUBD}}"
#############LOCAL_PDF_RECLASS=$1; shift
# shellcheck disable=SC2116,SC2086
#? LOCAL_VIRT_NODES=$(echo ${*//cfg01/}) # unquoted to filter space
#? NODE_MASK="${LOCAL_VIRT_NODES// /|}"

# push to cfg01 current git repo first (including submodules), at ~ubuntu/opnfv
# later we move it to ~root/opnfv (and ln as ~root/fuel); delete the temp clone
####remote_tmp="${SSH_SALT}:$(basename "${OPNFV_TMP_DIR}")"
#STORAGE_DIR=$(dirname "${LOCAL_PDF_RECLASS}")
#REL_STORAGE_DIR_PATH=${STORAGE_DIR#${LOCAL_GIT_DIR}}
#if [[ "${REL_STORAGE_DIR_PATH}" == "${STORAGE_DIR}" ]]
#then
#  REL_STORAGE_DIR_PATH=""
#fi
#rsync -Erl --delete -e "ssh ${SSH_OPTS}" \
#  --exclude={.gitignore,"$REL_STORAGE_DIR_PATH"} \
#  "${LOCAL_GIT_DIR}/" "${remote_tmp}/"
#if [ -n "${LOCAL_PDF_RECLASS}" ] && [ -f "${LOCAL_PDF_RECLASS}" ]; then
#  rsync -e "ssh ${SSH_OPTS}" "${LOCAL_PDF_RECLASS}" \
#    "${remote_tmp}${F_GIT_SUBD}/mcp/${OPNFV_RDIR}/opnfv/"
#fi
#####local_vcp_img=$(dirname "${LOCAL_PDF_RECLASS}")/$(basename "${OPNFV_VCP_IMG}")
#####if [ -e "${local_vcp_img}" ]; then
#####  rsync -L -e "ssh ${SSH_OPTS}" "${local_vcp_img}" \
#####    "${remote_tmp}${F_GIT_SUBD}/${OPNFV_VCP_IMG}"
#####fi

# ssh to cfg01
# shellcheck disable=SC2086,2087

###  mkdir -p /srv/salt /usr/share/salt-formulas/reclass

#?  ln -sf ${OPNFV_FUEL_DIR}/mcp/reclass /srv/salt

  cp -avr ${OPNFV_FUEL_DIR}/mcp/metadata/service/* /srv/salt/reclass/classes/service/
#?  cp -r ${OPNFV_FUEL_DIR}/mcp/metadata/service /usr/share/salt-formulas/reclass
#  cd /srv/salt/reclass/classes/service && \
#    ln -sf /usr/share/salt-formulas/reclass/service/opendaylight

  # Armband APT-MK nightly/extra repo for forked & extended reclass
#?  wget -qO - https://linux.enea.com/apt-mk/public.gpg | apt-key add -
#?  echo 'deb http://linux.enea.com/apt-mk/xenial nightly extra' > \
#?    '/etc/apt/sources.list.d/armband_mcp_extra.list'
#?  apt-get update

#???  cd /srv/salt/scripts
#???  export DEBIAN_FRONTEND=noninteractive
#???  echo 'Dpkg::Use-Pty "0";' > /etc/apt/apt.conf.d/90silence-dpkg
#???  OLD_DOMAIN=\$(grep -sPzo "id: cfg01\.\K(\S*)" /etc/salt/minion.d/minion.conf) || true
#???  BOOTSTRAP_SALTSTACK_OPTS=" -r -dX stable 2017.7 " \
#???    MASTER_HOSTNAME=cfg01.${CLUSTER_DOMAIN} DISTRIB_REVISION=nightly \
#???      EXTRA_FORMULAS="nfs panko gnocchi oslo-templates" \
#???        ./salt-master-init.sh
#???  salt-key -Ay

  cp -avr ${OPNFV_FUEL_DIR}/mcp/salt-formulas/* /srv/salt/formula/salt-formulas/
  ln -sf ${OPNFV_FUEL_DIR}/mcp/salt-formulas/salt-formula-opendaylight/* /srv/salt/env/prd/
  ln -sf ${OPNFV_FUEL_DIR}/mcp/salt-formulas/salt-formula-tacker/* /srv/salt/env/prd/

  ln -sf /srv/salt/formula/salt-formulas/salt-formula-opendaylight/metadata/service \
         /srv/salt/reclass/classes/service/opendaylight
  ln -sf /srv/salt/formula/salt-formulas/salt-formula-tacker/metadata/service \
         /srv/salt/reclass/classes/service/tacker

#  cd ${OPNFV_FUEL_DIR}/mcp/patches && ./patch.sh patches.list formulas
#  cd ${OPNFV_FUEL_DIR}/mcp/patches && ./patch.sh patches.list reclass

##?#?#?#  source ${OPNFV_FUEL_DIR}/mcp/scripts/lib.sh
#????  wait_for 3.0 "salt-call state.apply salt"

##???  # In case scenario changed (and implicitly domain name), re-register minions
##???  if [ -n "\${OLD_DOMAIN}" ] && [ "\${OLD_DOMAIN}" != "${CLUSTER_DOMAIN}" ]; then
##???    salt "*.\${OLD_DOMAIN}" cmd.run "grep \${OLD_DOMAIN} -sRl /etc/salt | \
##???      xargs --no-run-if-empty sed -i 's/\${OLD_DOMAIN}/${CLUSTER_DOMAIN}/g'; \
##???        service salt-minion restart" || true
##???    salt-key -yd "*.\${OLD_DOMAIN}"
##???    salt-key -Ay
##???  fi

####?#?#?#?#?#?#?#?#?#?#  # Init specific to VMs on FN (all for virtual, cfg|mas for baremetal)
####?#?#?#?#?#?#?#?#?#?#  wait_for 3.0 'salt -C "cfg01*" state.apply linux'
####?#?#?#?#?#?#?#?#?#?#  if [[ "${LOCAL_VIRT_NODES}" =~ mas ]]; then
####?#?#?#?#?#?#?#?#?#?#    wait_for 3.0 'salt -C "mas*" test.ping'
####?#?#?#?#?#?#?#?#?#?#  else
####?#?#?#?#?#?#?#?#?#?#    wait_for 3.0 '(for n in ${LOCAL_VIRT_NODES}; do salt -C \${n}.* test.ping || exit; done)'
####?#?#?#?#?#?#?#?#?#?#  fi
####?#?#?#?#?#?#?#?#?#?#  wait_for 3.0 'salt -C "E@^(${NODE_MASK}|cfg01).*" saltutil.sync_all'
####?#?#?#?#?#?#?#?#?#?#  wait_for 3.0 'salt -C "E@^(${NODE_MASK}|cfg01).*" state.apply salt'
####?#?#?#?#?#?#?#?#?#?#
####?#?#?#?#?#?#?#?#?#?#  wait_for 3.0 'salt -C "E@^(${NODE_MASK}).*" state.sls linux.system,linux.storage'
####?#?#?#?#?#?#?#?#?#?#  wait_for 2.0 'salt -C "E@^(${NODE_MASK}).*" state.sls linux.network'
####?#?#?#?#?#?#?#?#?#?#  salt -C "E@^(${NODE_MASK}).*" system.reboot
####?#?#?#?#?#?#?#?#?#?#  wait_for 90.0 'salt -C "E@^(${NODE_MASK}).*" test.ping'
####?#?#?#?#?#?#?#?#?#?#  wait_for 3.0 'salt -C "E@^(${NODE_MASK}).*" pkg.upgrade refresh=False dist_upgrade=True'
####?#?#?#?#?#?#?#?#?#?#
####?#?#?#?#?#?#?#?#?#?#  wait_for 3.0 'salt -C "E@^(${NODE_MASK}|cfg01).*" state.sls ntp'
####?#?#?#?#?#?#?#?#?#?#
  ####if [ -f "${OPNFV_FUEL_DIR}/${OPNFV_VCP_IMG}" ]; then
  ####  mkdir -p "${OPNFV_VCP_DIR}"
  ####  mv "${OPNFV_FUEL_DIR}/${OPNFV_VCP_IMG}" "${OPNFV_VCP_DIR}/"
  ####fi
##SALT_INSTALL_END

## ACAB
# pfff
sed -i -e "s|return 'start/running' in |return 'is running' in |" \
       -e "s|ret = _default_runlevel|return _default_runlevel|" \
    /usr/lib/python2.7/dist-packages/salt/modules/upstart.py

### THIS NEEDS TO BE FIXED
sudo chown salt:salt -R /srv/salt

#### FIXME
service salt-minion start

if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
    exec /usr/bin/salt-master --log-file-level=quiet --log-level=info "$@"
else
    exec "$@"
fi

