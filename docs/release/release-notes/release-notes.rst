.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. (c) Open Platform for NFV Project, Inc. and its contributors

========
Abstract
========

This document compiles the release notes for the ``Gambia`` release of
OPNFV when using Fuel as a deployment tool.

Starting with this release, both ``x86_64`` and ``aarch64`` architectures
are supported at the same time by the ``fuel`` codebase.

===============
Important Notes
===============

These notes provides release information for the use of Fuel as deployment
tool for the Gambia release of OPNFV.

The goal of the Gambia release and this Fuel-based deployment process is
to establish a lab ready platform accelerating further development
of the OPNFV infrastructure.

Carefully follow the installation instructions.

=======
Summary
=======

For Gambia, the typical use of Fuel as an OpenStack installer is
supplemented with OPNFV unique components such as:

- `OpenDaylight`_

As well as OPNFV-unique configurations of the Hardware and Software stack.

This Gambia artifact provides Fuel as the deployment stage tool in the
OPNFV CI pipeline including:

- Documentation built by Jenkins

  - overall OPNFV documentation

  - this document (release notes)

  - installation instructions

- Automated deployment of Gambia with running on baremetal or a nested
  hypervisor environment (KVM)

- Automated validation of the Gambia deployment

============
Release Data
============

+--------------------------------------+--------------------------------------+
| **Project**                          | fuel                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Repo/tag**                         | opnfv-7.0.0                          |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Gambia 7.0                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | TBD     2018                         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Purpose of the delivery**          | Gambia alignment to Released         |
|                                      | MCP baseline + features and          |
|                                      | bug-fixes for the following          |
|                                      | feaures:                             |
|                                      |                                      |
|                                      | - OpenDaylight                       |
|                                      | - DPDK                               |
+--------------------------------------+--------------------------------------+

Version Change
==============

Module Version Changes
----------------------
This is the Gambia 7.0 release.
It is based on following upstream versions:

- MCP Base Release

- OpenStack Pike Release

- OpenDaylight Oxygen Release

Document Changes
----------------
This is the Gambia 7.0 release.
It comes with the following documentation:

- :ref:`fuel-installation`

- Release notes (This document)

- :ref:`fuel-userguide`

Reason for Version
==================

Feature Additions
-----------------

**JIRA TICKETS:**
None

Bug Corrections
---------------

**JIRA TICKETS:**

`Gambia 7.0 bug fixes  <https://jira.opnfv.org/issues/?filter=12318>`_

(Also See respective Integrated feature project's bug tracking)

Deliverables
============

Software Deliverables
---------------------

- `Fuel multiarch (x86_64, aarch64) installer script files <https://git.opnfv.org/fuel>`_

Documentation Deliverables
--------------------------

- :ref:`fuel-installation`

- Release notes (This document)

- :ref:`fuel-userguide`

=========================================
Known Limitations, Issues and Workarounds
=========================================

System Limitations
==================

- **Max number of blades:** 1 Jumpserver, 3 Controllers, 20 Compute blades

- **Min number of blades:** 1 Jumpserver

- **Storage:** Cinder is the only supported storage configuration

- **Max number of networks:** 65k


Known Issues
============

**JIRA TICKETS:**

`Known issues <https://jira.opnfv.org/issues/?filter=12317>`_

(Also See respective Integrated feature project's bug tracking)

Workarounds
===========

**JIRA TICKETS:**

None

(Also See respective Integrated feature project's bug tracking)

============
Test Results
============
The Gambia 7.0 release with the Fuel deployment tool has undergone QA test
runs, see separate test results.

==========
References
==========
For more information on the OPNFV Gambia 7.0 release, please see:

OPNFV
=====

1) `OPNFV Home Page <https://www.opnfv.org>`_
2) `OPNFV Documentation <https://docs.opnfv.org>`_
3) `OPNFV Software Downloads <https://www.opnfv.org/software/download>`_

OpenStack
=========

4) `OpenStack Pike Release Artifacts <https://www.openstack.org/software/pike>`_

5) `OpenStack Documentation <https://docs.openstack.org>`_

OpenDaylight
============

6) `OpenDaylight Artifacts <https://www.opendaylight.org/software/downloads>`_

Fuel
====

7) `Mirantis Cloud Platform Documentation <https://docs.mirantis.com/mcp/latest>`_

.. _`OpenDaylight`: https://www.opendaylight.org/software
