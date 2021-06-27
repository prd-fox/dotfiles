#!/bin/bash

export JAVA_HOME=/usr/local/opt/openjdk@11

export GPG_TTY=$(tty)

mkdir -p $HOME/go
export GOPATH=$HOME/go
export GOCACHE=/Users/peterfox/gocache

export AWS_DEFAULT_PROFILE=adfs

export PATH="${GOPATH}/bin:${PATH}"

export TESSERA_JAR="/Users/peterfox/IdeaProjects/tessera/tessera-dist/tessera-app/build/libs/tessera-app-20.10.2-SNAPSHOT-app.jar"

export ANDROID_HOME="/Users/peterfox/Library/Android/sdk"
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
# default to Java 11
java11

alias psgeth="ps -ef | grep geth"
alias makegeth="make clean && make all && cp /Users/peterfox/IdeaProjects/quorum/build/bin/geth /usr/local/bin/geth && rm -r build/bin"
alias clearmaven="rm -rf /Users/peterfox/.m2/repository/*"
alias mvni="mvn clean && mvn install"
alias mvnist="mvn clean && mvn install -DskipTests=true"
alias resetes="cd ../.. && rm -rf elasticsearch-7.6.2 && tar -xvf elasticsearch-7.6.2-darwin-x86_64.tar.gz && cd elasticsearch-7.6.2/bin && ./elasticsearch"
alias pcl="/Users/peterfox/Downloads/pcl aws --sandbox-user --domain emea --sid d550749"
alias top="htop"
alias ping="prettyping"
alias ls="exa -a --long"
alias cat="bat"

function testCommit {
	cd ~/IdeaProjects/TaskManager
	echo "a" >> a.txt
	git add -A
	git commit -am "Next"
}

function attach {
	cd /Users/peterfox/IdeaProjects/quorum-examples/examples/7nodes
	geth attach qdata/dd${1}/geth.ipc
}

function resetdocker() {
	docker stop -t 1 $(docker ps -aq)
	docker rm $(docker ps -aq)
	docker rmi -f $(docker images -q)
	docker network prune -f
	docker volume prune -f
	docker system prune --all --force --volumes
}

function resetdockerKeepImages() {
        docker stop -t 1 $(docker ps -aq)
        docker rm $(docker ps -aq)
        docker network prune -f
        docker volume prune -f
}

function runSingleAcceptanceTest {
	local rnd=${RANDOM}
	docker run --rm --network host -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/acctests${rnd}:/tmp/acctests${rnd} quorumengineering/acctests:latest test -Pauto -Dtags="${1}" -Dauto.outputDir=/tmp/acctests${rnd} -Dnetwork.forceDestroy=true
}
