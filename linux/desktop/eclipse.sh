#!/bin/bash
err_report() {
    echo "Error on line $1"
}

trap 'err_report $LINENO' ERR

export JAVA_HOME=/opt/java/jdk1.8
export PATH=$JAVA_HOME:$JAVA_HOME/bin:/opt/eclipse:$PATH

${JAVA_HOME}/bin/java -version

#echo $PATH

/opt/eclipse/eclipse
