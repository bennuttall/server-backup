# Server Backup

Some server backup scripts I wrote. Minimalist and easily configurable. 

## Why

There are existing tools that will back up your files and databases and a million other things. I wrote these scripts to personally manage the backups on my server, it's very minimalist and only does the things I want it to. They're short, concise, readable, and easy to configure to do things slightly differently or do extra tasks.

## Contents

- MySQL backup
    - This backs up all MySQL databases and gzips the .sql dumps
- User files backup
    - This backs up the home directories of all users specified in the script as a gzipped tarball

## Configuration

- Set your MySQL user (or leave as root) and password
- List all users whose home directories you want to back up in the ```USERS``` array
- Configure the directory location and structure of your backups, defaults are ```/var/backups/users/user/date/hour/``` for user files and databases and ```/var/backups/mysql_core/date/hour/``` for mysql core databases
- The scripts echo output to stdout, so you can run and see the output, or run outputting messages to a file
- Configure automated run time with crontab

## Usage

Once configured correctly, run each file as root:

```
    sudo su
    ./mysql_backup.sh
```

Running like this will echo information to the screen. You can also direct all output to a file:

```
    sudo su
    ./mysql_backup.sh
```

Ideally, you'd set up a cron job to schedule the running of these scripts:

```
    0 4,16 * * * /home/ben/mysql_backup.sh >> /var/log/backups/mysql.log 2>&1
    0 4,16 * * * /home/ben/user_files_backup.sh >> /var/log/backups/files.log 2>&1
```

Adding these line to crontab (```sudo crontab -e```) will schedule both backups every 12 hours at 4am and 4pm. It will also add all output in to the logfiles specified.

# The backups

Example of the structure of backups:

```
/var/backups/users/

├── ben
│   ├── 2013-03-28
│   │   ├── 04
│   │   │   └── ben-2013-03-28-040000.tar.gz
│   │   └── 16
│   │       └── ben-2013-03-28-160000.tar.gz
│   └── 2013-03-29
│       └── 04
│           └── ben-2013-03-29-040000.tar.gz
└── mcrraspjam
    ├── 2013-03-28
    │   ├── 04
    │   │   ├── mcrraspjam-2013-03-28-040000.sql.gz
    │   │   └── mcrraspjam-2013-03-28-040000.tar.gz
    │   └── 16
    │       ├── mcrraspjam-2013-03-28-160000.sql.gz
    │       └── mcrraspjam-2013-03-28-160000.tar.gz
    └── 2013-03-29
        └── 04
            ├── mcrraspjam-2013-03-29-040000.sql.gz
            └── mcrraspjam-2013-03-29-040000.tar.gz

```

Notes:
The mysql core database backups are kept in ```/var/backups/mysql_core/```
If a username matches a database name they are conveniently stored in the same backup directory.
