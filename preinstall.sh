#!/bin/bash

webuser='apache'

# FreePBX Startup
echo "Prepping for a typical FreePBX install. Your mileage may vary. It\'s OK if some things fail..."

# SELinux
echo '  Disabling SE Linux, if installed...'
selinuxenabled 0

# Change permissions
echo '  Changing folder permissions to allow read/write...'
chgrp -R $webuser freepbx/logs/
chmod -R g+w freepbx/logs
chgrp -R $webuser freepbx/cache/
chmod -R g+w freepbx/cache/
chgrp -R $webuser freepbx/config/
chmod -R g+w freepbx/config/
chgrp -R $webuser modules/freeswitch/config/
chmod -R g+w modules/freeswitch/config/
chgrp -R $webuser modules/asterisk/config/
chmod -R g+w modules/asterisk/config/
mkdir -p upload/
chgrp -R $webuser upload/
chmod -R g+w upload/

# Make FS conf directory writable
if [ -d '/usr/local/freeswitch/' ]; then
	echo '  Making FreeSWITCH configs writable...'
	chgrp -R $webuser /usr/local/freeswitch/conf/
	chmod -R g+w /usr/local/freeswitch/conf/*
fi

# Make Asterisk conf directory writable
if [ -d '/etc/asterisk/' ]; then
	echo '  Making Asterisk configs writable...'
	chgrp -R $webuser /etc/asterisk/*
	chmod -R g+w /etc/asterisk/*
fi

# Make ODBC files writable
echo '  Making ODBC configs writable...'
chgrp $webuser /etc/odbc.ini
chmod g+w /etc/odbc.ini

echo 
echo 'Done!'

