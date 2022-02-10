#!/bin/bash
set -e
set -x

SCRIPTDIR=`dirname "$(readlink -f "$0")"`
MHN_HOME=$SCRIPTDIR/..

if [ -f /etc/debian_version ]; then
    OS=Debian  # XXX or Ubuntu??
    INSTALLER='apt-get'

elif [ -f /etc/redhat-release ]; then
    OS=RHEL
    export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH
    yum -y update
    yum -y groupinstall "Development tools"
    yum -y install openssl-devel wget

    if  [ ! -f /usr/bin/python3 ]; then
        yum install -y python3
    fi

    if  [ ! -f /usr/local/bin/pip2.7 ]; then
        #install pip
        yum install -y python3-pip

        #install virtualenv
        pip install virtualenv
    fi

else
    echo -e "ERROR: Unknown OS\nExiting!"
    exit -1
fi
