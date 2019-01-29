#! /bin/bash
li=$(uname -s)
li2="${li,,}"

u1=$(cat /etc/*-release | grep ubuntu)
f1=$(cat /etc/*-release | grep fedora)
c1=$(cat /etc/*-release | grep centos)
s1=$(cat /etc/*-release | grep suse)


py1="$(python --version 2>&1)"
py2="$(which python 2>&1)"
pi1="$(pip -V 2>&1)"
pi2="$(which pip 2>&1)"
dk1="$(docker version 2>&1)"
dk2="$(which docker 2>&1)"
dc1="$(docker-compose version 2>&1)"
dc2="$(which docker-compose 2>&1)"
gc1="$(go version 2>&1)"
gc2="$(which go 2>&1)"
pipl="$(pip list 2>&1)"

if [ ! -z "$u1" ]
then 
	mi=$(lsb_release -cs)
	mi2="${mi,,}"
	ji=$(cat /etc/*-release | grep DISTRIB_ID | awk '{split($0,a,"=");print a[2]}')
	ki="${ji,,}"

	if [ "$ki" == "ubuntu" ]
	then
   	echo "THIS BOX IS UBUNTU"
   	cm1="apt-get"
   	cm2="apt-key"
	fi
fi

if [ ! -z "$f1" ]
then
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"=");print a[2]}')
        ki="${ji,,}"
fi

if [ ! -z "$c1" ]
then
	echo "it is a centos"
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        cm1="yum -y"
fi #end of centos


# Package checks

	if [  -z "$py2" ]
        then
          echo "python is NOT INSTALLED"
        else
          echo "python version is: $py1"
          echo "python is installed in: $py2"
        fi
       
	if [  -z "$pi2" ]
        then
          echo "pip is NOT INSTALLED"
        else
          echo "pip version is: $pi1"
          echo "pip is installed in: $pi2"
        fi

        if [  -z "$dk2" ]
        then 
          echo "Docker is NOT INSTALLED"
        else
          echo "Docker version is: $dk1"
          echo "Docker is installed in: $dk2"
        fi
	if [  -z "$dc2" ]
        then
          echo "Docker-compose is NOT INSTALLED"
        else
          echo "Docker-compose version is: $dc1"
          echo "Docker-compose is installed in: $dc2"
        fi
	if [  -z "$gc2" ]
        then
          echo "go is NOT INSTALLED"
        else
          echo "go version is: $gc1"
          echo "go is installed in : $gc2"
        fi
       
        if [[ ! -z "$py2" ]]
        then
          echo "DO you need pip/python/ML packages list[y/n] ?"
          read pl
          if [ "$pl" = "y" ]
          then 
           echo "$pipl"
          fi
        fi

