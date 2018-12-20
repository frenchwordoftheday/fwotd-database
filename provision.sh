#!/bin/bash

################################################################################
###                                                                          ###
###   Builds and executes the French Word Of The Day database server         ###
###                                                                          ###
################################################################################


set -e;
reset;clear;


################################################################################
###                                                                          ###
###   Variable declarations                                                  ###
###                                                                          ###
################################################################################
applicationContext=frenchwordoftheday
runningContainerName=fwotd-database
containerSourcePort=3306
hostTargetPort=13306
phpmyadminPort=13080
containerName=$applicationContext/$runningContainerName
containerTag=latest


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   Build the Docker image                                           ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker build -t $containerName .


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   List the running containers (before)                             ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker ps


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   Stop and remove the application specific container(s)            ###"
echo "###                                                                    ###"
echo "##########################################################################"
{ docker stop $runningContainerName || true; echo "stopped..."; } | tr "\n" " ";echo;
{ docker rm   $runningContainerName || true; echo "removed..."; } | tr "\n" " ";echo;


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   Run docker-compose to launch everything                          ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker-compose up -d


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   List the running containers (after)                              ###"
echo "###                                                                    ###"
echo "##########################################################################"
docker ps


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   Sleep a bit to allow containers time to listen for connections   ###"
echo "###                                                                    ###"
echo "##########################################################################"
sleep 30


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   Open phpMyAdmin in the firefox web broswer                       ###"
echo "###                                                                    ###"
echo "##########################################################################"
firefox http://localhost:$phpmyadminPort &


echo
echo
echo "##########################################################################"
echo "###                                                                    ###"
echo "###   Fin                                                              ###"
echo "###                                                                    ###"
echo "##########################################################################"
