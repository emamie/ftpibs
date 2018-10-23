# ftpibs
FTP Incremental Backup Service

## Install

Copy ftpibs.sh script to custom path
```
$ cp ftpibs.sh /var/backup_service/
```

Edit variables in ftpibs.sh
```
$ nano /var/backup_service/ftpibs.sh
```

Add cron job
```
0 2 * * * root sh /var/backup_service/ftpibs.sh
```

