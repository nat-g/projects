## How to build a Network Storage Device on a Raspberry Pi

### Prerequisites

You would need these things to build it:
* *Hub:* You'll need it if you have two HDDs. Raspberry Pi isn't powerful enough to power up both drivers. 
* *Raspberry Pi*
* *Two HDDs:* You can get by with just one. And you'll need two if you want to make them redundant. But since we're engineers why wouldn't you. :P
* *Some CLI knowledge*

### Tech desicions you need to make: 
* *Filesystem format:* I'll use NTFS here
* *Network Shares tools:* I'll be using Samba here

### Step by step guide
1. Once you have everything ready. Hook all the hardware up.

2. Then log in to your Raspberry Pi:
```
Login as: pi
pi@192.168.1.13's password:
```
3. Add support for NTFS-formatted disks:
```
sudo apt-get install ntfs-3g
```
4. Chech unmounted partitions on Raspberry Pi. You should have at least 2, if you're setting up two HDDs. Plus SD card.
The first disk /dev/mmcb1k0 is the SD card inside the Raspberry Pi. The second disk and third discs are /dev/sda and /dev/sdb respectively, which are your external hard drives.
```
sudo fdisk -l
```
5. So the next step would be to mount /dev/sda and /dev/sdb. But first let's create directories to mount the drives to.
```
sudo mkdir /media/USBHDD1
sudo mkdir /media/USBHDD2
```
6. Then let's mount our drives to these directories.
```
sudo mount -t auto /dev/sda1 /media/USBHDD1
sudo mount -t auto /dev/sdb1 /media/USBHDD2
```
7. It's time to install Samba.
```
sudo apt-get install samba samba-common-bin
```
8. Let’s make a backup copy of the Samba configuration file in case we need to revert to it.
```
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.old
```
9. Then open Samba config file, so we can make some necessary changes to our setup.
```
sudo nano /etc/samba/smb.conf
```
10. First let's change security settings to allow only authorized users to access the drive, otherwise anyone with general access to our network (like guest Wi-Fi users) will be able to walk right in. 
For that scroll to the *Authentication* section and remove the # symbol from the *security = user* line

11. Then let's add our Backup drive. Scroll all the way down to the very bottom of the file and add this text:
```
[Backup]
comment = Backup Folder
path = /media/USBHDD1/shares
valid users = @users
force group = users
create mask = 0660
directory mask = 0771
read only = no
```
Whatever is in the brackets will be the name of the folder as it appears on the network share.
12. Restart the Samba daemon.
```
sudo /etc/init.d/samba restart
```
13. And since we enabled user authentication, we have to create a new user.
```
sudo useradd your_username -m -G users
sudo passwd your_username
sudo smbpasswd -a your_username
```
You'll be prompted to enter your password twice at this point.
14. To test the network shares.
```
cd /media/USBHDD1
ls
```
15. To make the external hard drives mount automatically, if our Pi restarts, we need to make some changes to fstab.
```
sudo vi /etc/fstab
```
16. Then make these entries in the file.
```
/dev/sda1 /media/USBHDD1 auto noatime 0 0
/dev/sda2 /media/USBHDD2 auto noatime 0 0
```
17. To make our drives redundant, we will install rsync and create a cron job to run the backup every night. 
So the first task is to install rsync.
```
sudo apt-get install rsync
```
18. Then open a cron scheduling table.
```
crontab -e
```
And make these changes to the file. 
```
0 3 * * * rsync -av --delete /media/USBHDD1/ /media/USBHDD2/
```
This command will run every day at 3am in the morning.

19. And that's it!
