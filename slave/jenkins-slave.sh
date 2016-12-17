#!/bin/bash

master_username=${JENKINS_USERNAME:-"admin"}
master_password=${JENKINS_PASSWORD:-"password"}
slave_executors=${EXECUTORS:-"1"}




echo "Running Jenkins Swarm Plugin...."

# jenkins swarm slave
JAR=`ls -1 /var/lib/jenkins/swarm-client-*.jar | tail -n 1`

if [[ "$@" != *"-master "* ]] && [ ! -z "$JENKINS_PORT_8080_TCP_ADDR" ]; then
PARAMS="-master http://${JENKINS_SERVICE_HOST}:${JENKINS_SERVICE_PORT}${JENKINS_CONTEXT_PATH} -tunnel ${JENKINS_SLAVE_SERVICE_HOST}:${JENKINS_SLAVE_SERVICE_PORT}${JENKINS_SLAVE_CONTEXT_PATH} -username ${master_username} -password ${master_password} -executors ${slave_executors}"
fi

echo Running java $JAVA_OPTS -jar $JAR -fsroot $HOME $PARAMS "$@"
exec java $JAVA_OPTS -jar $JAR -fsroot $HOME $PARAMS "$@"
