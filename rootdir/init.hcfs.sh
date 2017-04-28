#!/system/bin/sh

MOUNTPT=/data
HCFSSRC=/etc/hcfs.conf
HCFSCONF=/data/hcfs.conf

SMARTCACHE=/data/smartcache
SMARTCACHEMTP=/data/mnt/hcfsblock
LOOPDEV=/dev/block/loop6
HCFSBLOCK=hcfsblock

init_hcfs() {
    rm -rf /data/data
    rm -rf /data/app
    # Adding folders for Kitkat
    rm -rf /data/app-lib
    rm -rf /data/dalvik-cache

    mkdir /data/data
    mkdir /data/app
    mkdir /data/app-lib
    mkdir /data/dalvik-cache
    mkdir /data/hcfs
    mkdir /data/hcfs/metastorage
    mkdir /data/hcfs/blockstorage

    /system/bin/hcfsconf enc ${HCFSSRC} ${HCFSCONF}

    while [ ! -e ${HCFSCONF} ]; do sleep 0.1; done

    /system/bin/hcfs -oallow_other,big_writes,writeback_cache,subtype=hcfs,fsname=/dev/fuse &

    while [ ! -e /dev/shm/hcfs_reporter ]; do sleep 0.1; done

    /system/bin/HCFSvol toggle_use_minimal_apk on 

    /system/bin/HCFSvol create hcfs_data internal
    /system/bin/HCFSvol mount hcfs_data /data/data

    chown system:system /data/data
    chmod 771 /data/data

    /system/bin/HCFSvol create hcfs_app internal
    /system/bin/HCFSvol mount hcfs_app /data/app

    chown system:system /data/app
    chmod 771 /data/app

    /system/bin/HCFSvol create hcfs_applib internal
    /system/bin/HCFSvol mount hcfs_applib /data/app-lib

    chown system:system /data/app-lib
    chmod 771 /data/app-lib

    /system/bin/HCFSvol create hcfs_dalvik internal
    /system/bin/HCFSvol mount hcfs_dalvik /data/dalvik-cache

    chown system:system /data/dalvik-cache
    chmod 771 /data/dalvik-cache

    /system/bin/HCFSvol create hcfs_external external

#    mkdir /mnt/shell/emulated 0700 shell shell
#    mkdir /storage/emulated 0555 root root
#    mkdir /storage/emulated/legacy 0555 root root

    /system/bin/HCFSvol mount hcfs_external /mnt/shell/emulated

    mkdir /mnt/shell/emulated/0 0700 root sdcard_r
    mkdir /mnt/shell/emulated/obb 0700 root sdcard_r
    #setprop init.svc.sdcard running 

#    mount -o bind /mnt/shell/emulated/0 /storage/emulated/legacy
    mount -o bind /mnt/shell/emulated/0 /storage/emulated/0

    #mkdir -p ${SMARTCACHEMTP}
    #chmod 771 ${SMARTCACHEMTP}
    #mkdir ${SMARTCACHE}
    #/system/bin/HCFSvol create hcfs_smartcache internal
    #/system/bin/HCFSvol mount hcfs_smartcache ${SMARTCACHE}
    #chown system:system ${SMARTCACHE}
    #chmod 771 ${SMARTCACHE}

    #if [ ! -e ${SMARTCACHE}/${HCFSBLOCK} ]; then
    #    #touch ${SMARTCACHE}/${HCFSBLOCK}
    #    #truncate -s 100M ${SMARTCACHE}/${HCFSBLOCK}
    #    dd if=/dev/zero of=${SMARTCACHE}/${HCFSBLOCK} bs=$((1024*1024)) count=100
    #    losetup ${LOOPDEV} ${SMARTCACHE}/${HCFSBLOCK}
    #    make_ext4fs ${LOOPDEV}
    #else
    #    losetup ${LOOPDEV} ${SMARTCACHE}/${HCFSBLOCK}
    #fi
    #mount -t ext4 ${LOOPDEV} ${SMARTCACHEMTP}

    #chown system:system ${SMARTCACHEMTP}
    #chmod 771 ${SMARTCACHEMTP}

    #if [ ! -e /data/app/hcfsblock ]; then
    #    touch /data/app/hcfsblock
    #    truncate -s 4G /data/app/hcfsblock
    #    losetup /dev/block/loop6 /data/app/hcfsblock
    #    make_ext4fs /dev/block/loop6
    #else
    #    losetup /dev/block/loop6 /data/app/hcfsblock
    #fi
    #mount -t ext4 /dev/block/loop6 /data/data
}

################################################
#
# MAIN
#
################################################

[ -n "`grep ${MOUNTPT} /proc/mounts | grep ext4`" ] && init_hcfs

touch /tmp/hcfs_ready
