#! /bin/bash
li=$(uname -s)
li2="${li,,}"

u1=$(cat /etc/*-release | grep ubuntu)
f1=$(cat /etc/*-release | grep ID= | grep fedora)
c1=$(cat /etc/*-release | grep ID= | grep centos)
s1=$(cat /etc/*-release | grep suse)
mac=$(sw_vers  | grep Mac)
echo "$mac"

py1="$(python --version 2>&1)"
py2="$(which python 2>&1)"
pi1="$(pip -V 2>&1)"
pi2="$(which pip 2>&1)"
dk1="$(docker --version 2>&1)"
dk2="$(which docker 2>&1)"
dc1="$(docker-compose --version 2>&1)"
dc2="$(which docker-compose 2>&1)"
gc1="$(go version 2>&1)"
gc2="$(which go 2>&1)"
pipl="$(pip list 2>&1)"
java1="$(java -version 2>&1)"
java2="$(which java 2>&1)"
javac1="$(javac -version 2>&1)"
javac2="$(which javac 2>&1)"

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
        echo " it is fedora"
fi

if [ ! -z "$c1" ]
then
	echo "it is a centos"
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"\"");print a[2]}')
        ki="${ji,,}"
        cm1="yum -y"
fi #end of centos

if [ ! -z "$mac" ]
then
	echo "It is a Mac"
	cm1="brew"
fi

# Package checks

	if [  -z "$py2" ] || [[ $py2 =~ ."no". ]]
        then
          echo "python is NOT INSTALLED"
        else
          echo "python version is: $py1"
          echo "python is installed in: $py2"
        fi
	if [ -z "$pi2" ] || [[ $pi2 =~ ."no". ]]
        then
          echo "pip is NOT INSTALLED"
        else
          echo "pip version is: $pi1"
          echo "pip is installed in: $pi2"
        fi

        if [  -z "$dk2" ] || [[ $dk2 =~ ."no". ]]
        then 
          echo "Docker is NOT INSTALLED"
        else
          echo "Docker version is: $dk1"
          echo "Docker is installed in: $dk2"
        fi
	if [  -z "$dc2" ] || [[ $dc2 =~ ."no". ]]
        then
          echo "Docker-compose is NOT INSTALLED"
        else
          echo "Docker-compose version is: $dc1"
          echo "Docker-compose is installed in: $dc2"
        fi
	if [  -z "$gc2" ] || [[ $gc2 =~ ."no". ]]
        then
          echo "go is NOT INSTALLED"
        else
          echo "go version is: $gc1"
          echo "go is installed in : $gc2"
        fi
       
	if [[ -z "$java2" ]] || [[ $java2 =~ ."no". ]]
        then
          echo "Java is not installed"
        else
          echo "Java version is : $java1"
          echo "Java is installed in : $java2"
	fi
	if [[ -z "$javac2" ]] || [[ $javac2 =~ ."no". ]]
        then
          echo "JavaCompiler is not installed"
        else
          echo "JavaCompiler version is : $javac1"
          echo "JavaCompiler is installed in : $javac2"
	fi

        if [[ ! -z "$pi2" ]] && [[ ! $pi2 =~ ."no". ]]
        then
          echo "DO you need pip/python/ML packages list[y/n] ?"
          read pl
          if [ "$pl" = "y" ]
          then 
           echo "$pipl"
          fi
        fi
