# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

MY_LOCAL_PATH := vendor/tera

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false

#BOARD_SEPOLICY_DIRS += \
#    $(MY_LOCAL_PATH)/sepolicy
#
#BOARD_SEPOLICY_UNION += \
#    hcfsapid.te \
#    hcfsd.te \
#    terafonn_app.te \
#    file_contexts \
#    fs_use \
#    seapp_contexts \
#    init_shell.te
#

PRODUCT_COPY_FILES += \
    $(MY_LOCAL_PATH)/bin/hcfs:system/bin/hcfs \
    $(MY_LOCAL_PATH)/bin/HCFSvol:system/bin/HCFSvol \
    $(MY_LOCAL_PATH)/bin/hcfsapid:system/bin/hcfsapid \
    $(MY_LOCAL_PATH)/bin/hcfsconf:system/bin/hcfsconf \
    $(MY_LOCAL_PATH)/etc/hcfs.conf:system/etc/hcfs.conf \
    $(MY_LOCAL_PATH)/lib/libfuse.so:system/lib/libfuse.so \
    $(MY_LOCAL_PATH)/lib/liblz4.so:system/lib/liblz4.so \
    $(MY_LOCAL_PATH)/lib/libHCFS_api.so:system/lib/libHCFS_api.so \
    $(MY_LOCAL_PATH)/lib/libjansson.so:system/lib/libjansson.so \
    $(MY_LOCAL_PATH)/lib/libcurl.so:system/lib/libcurl.so \
    $(MY_LOCAL_PATH)/lib/libzip.so:system/lib/libzip.so \
    $(MY_LOCAL_PATH)/rootdir/init.hcfs.sh:root/init.hcfs.sh \
    $(MY_LOCAL_PATH)/rootdir/init.tera.rc:root/init.tera.rc 

#$(MY_LOCAL_PATH)/lib/libterafonnapi.so:system/lib/libterafonnapi.so \

## HCFS management app
#PRODUCT_PACKAGES +=\
#    HopebayHCFSmgmt \
#    TeraService \
#    Launcher3 \
#    HBTUpdater
