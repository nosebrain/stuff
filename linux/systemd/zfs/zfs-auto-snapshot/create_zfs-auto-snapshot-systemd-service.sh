#!/bin/bash
INSTALL_DIR='/usr/lib/systemd/system/'
PATH_TO_ZFS_AUTO_SNAPSHOT='/usr/local/sbin/zfs-auto-snapshot'
CONFIGS='hourly|24|hourly daily|31|daily weekly|8|weekly monthly|12|monthly '

for CONFIG in $CONFIGS; do  
  DESCRIPTION=`echo $CONFIG | cut -d '|' -f1`
  KEEP=`echo $CONFIG | cut -d '|' -f2`
  TIMER_ON=`echo $CONFIG | cut -d '|' -f3`

  echo "[Unit]
  Description=ZFS ${DESCRIPTION} snapshot service

  [Service]
  ExecStart=${PATH_TO_ZFS_AUTO_SNAPSHOT} --skip-scrub --prefix=znap --label=${DESCRIPTION} --keep=${KEEP} //" > ${INSTALL_DIR}/zfs-auto-snapshot-${DESCRIPTION}.service

  echo "# See systemd.timers and systemd.time manpages for details
  [Unit]
  Description=ZFS ${DESCRIPTION} snapshot timer

  [Timer]
  OnCalendar=${TIMER_ON}
  Persistent=true

  [Install]
  WantedBy=timers.target" > ${INSTALL_DIR}/zfs-auto-snapshot-${DESCRIPTION}.timer
done
