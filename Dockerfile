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
###   Define and copy the secret(s) for user authentication            ###
###                                                                    ###
##########################################################################
ENV   sourceSecretsDirectory    secrets
ENV   targetSecretsDirectory    /run/secrets/mysql
ENV   secretFileRootPassword    secret-mysql-root-user-password
ENV   secretFileUserPassword    secret-mysql-fwotd-user-password

COPY  $sourceSecretsDirectory/* $targetSecretsDirectory/
RUN   ls -lha                   $targetSecretsDirectory/


##########################################################################
###                                                                    ###
###   Set the MySQL environment variables                              ###
###                                                                    ###
##########################################################################
ENV   MYSQL_ROOT_PASSWORD_FILE  $targetSecretsDirectory/$secretFileRootPassword
ENV   MYSQL_DATABASE            FWOTD
ENV   MYSQL_USER                fwotd
ENV   MYSQL_PASSWORD_FILE       $targetSecretsDirectory/$secretFileUserPassword


##########################################################################
###                                                                    ###
###   Copy the database creation SQL to be executed at startup         ###
###                                                                    ###
##########################################################################
ENV   sourceSQLDumpDirectory    sql
ENV   targetSQLDumpDirectory    /docker-entrypoint-initdb.d

COPY  $sourceSQLDumpDirectory/* $targetSQLDumpDirectory/
RUN   ls -lha                   $mysqlDataLoadDirectory/


##########################################################################
###                                                                    ###
###   Expose the port(s) to be used by running containers              ###
###                                                                    ###
##########################################################################
EXPOSE 3306
