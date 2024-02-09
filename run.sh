#! /bin/sh

set -e


if [ "${SCHEDULE}" = "**None**" ]; then
  echo "You must set a backup schedule."
  exit 1
fi

echo "Performing an immediate backup..."
sh backup.sh # perform an immediate backup
echo "${SCHEDULE} backup.sh >> /var/log/script.log" > crontab.txt
echo "Adding a scheduled job"
/usr/bin/crontab crontab.txt

/usr/sbin/crond -f -l 8

echo "Job is scheduled, here is a list of your schedule"
cat /etc/crontab
