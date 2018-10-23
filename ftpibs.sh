#!/usr/bin/env bash

# FTPIBS (FTP Incremental Backup Service)
# Copyright (C) 2018 by Hassan Emamie <h.emamie@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#
# This script can be found at:
# https://github.com/emamie/ftpibs
#

#
# Thanks very much to all users and contributors! All bug-reports,
# feature-requests, patches, etc. are greatly appreciated! :-)
#

# init
#
version="1.0.0"
version_date="2018-10-23"
version_string="ftpibs-sh $version ($version_date)"

##############################################################################################
## Configs ###################################################################################
##############################################################################################
backup_dir=/var/www/public_html
backup_output=/var/backup_service/output

ftp_host=127.0.0.1
ftp_port=21
ftp_user=user
ftp_pass=pass
ftp_path=/
##############################################################################################
##############################################################################################
##############################################################################################
time=`date +%b-%d-%y%s`          # This Command will add date in Backup File Name.

backup_filename=backup-$time.tar.gz     # Here i define Backup file name format.
backup_snapshot=snapshot.snar

## create output dir #########################################################################
mkdir -p $backup_output

## Backup dir ################################################################################
cd $backup_dir
tar -cvf $backup_output/$backup_filename -g $backup_output/$backup_snapshot .  #Backup Command

## FTP backup to remote server ###############################################################
cd $backup_output # local change dir
ftp -inv $ftp_host $ftp_port << EOF # connect ftp
user $ftp_user $ftp_pass
binary

mkdir $ftp_path
cd $ftp_path

put $backup_filename
put $backup_snapshot

bye
EOF

echo "Backup `$backup_dir` to `$backup_filename`"