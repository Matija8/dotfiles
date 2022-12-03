printf "Not a script!\n"
exit

# gnome-disks
# https://askubuntu.com/questions/59064/how-to-run-a-checkdisk
sudo apt install gnome-disk-utility
gnome-disks

# https://askubuntu.com/questions/182446/how-do-i-view-all-available-hdds-partitions
# option 1:
sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
# option 2:
sudo fdisk -l

# smartd, smartctl
sudo apt install smartmontools
smartctl
# TODO smartmontools documentation

# Other:
# https://askubuntu.com/questions/156994/how-to-fix-partition-does-not-start-on-physical-sector-boundary-warning
