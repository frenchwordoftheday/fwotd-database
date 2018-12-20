##########################################################################
###                                                                    ###
###   Dockerfile for the frenchwordoftheday.com database               ###
###                                                                    ###
##########################################################################
FROM mysql

MAINTAINER Troy Burney “troy@softwareshinobi.com”

USER root


##########################################################################
###                                                                    ###
###   Set (read: hardcode) the MySQL environment variables             ###
###                                                                    ###
##########################################################################
ENV MYSQL_ROOT_PASSWORD   F3HqAECS85S7
ENV MYSQL_DATABASE        FWOTD
ENV MYSQL_USER            fwotd
ENV MYSQL_PASSWORD        Qg5Q6yKhwMME

ENV mysqlDataLoadDirectory /docker-entrypoint-initdb.d


##########################################################################
###                                                                    ###
###   Copy the database creation SQL to be executed at startup         ###
###                                                                    ###
##########################################################################
COPY *.sql  $mysqlDataLoadDirectory
RUN ls -lha $mysqlDataLoadDirectory


##########################################################################
###                                                                    ###
###   Expose the port(s) to be used by running containers              ###
###                                                                    ###
##########################################################################
EXPOSE 3306
