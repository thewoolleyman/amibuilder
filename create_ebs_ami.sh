#!/bin/sh

ssh -i $keypair \
  ubuntu@$host \
'codename=karmic
release=9.10
tag=server
if [ $(uname -m) = "x86_64" ]; then
  arch=x86_64
  arch2=amd64
  ebsopts="--kernel=aki-fd15f694 --ramdisk=ari-c515f6ac"
  ebsopts="$ebsopts --block-device-mapping /dev/sdb=ephemeral0"
else
  arch=i386
  arch2=i386
  ebsopts="--kernel=aki-5f15f636 --ramdisk=ari-0915f660"
  ebsopts="$ebsopts --block-device-mapping /dev/sda2=ephemeral0"
fi


imagesource=http://uec-images.ubuntu.com/releases/$codename/release/unpacked/ubuntu-$release-$tag-uec-$arch2.img.tar.gz
image=/mnt/$codename-$tag-uec-$arch2.img
imagedir=/mnt/$codename-uec-$arch2
wget --progress=dot:mega -O- $imagesource |
  sudo tar xzf - -C /mnt
sudo mkdir -p $imagedir
sudo mount -o loop $image $imagedir


# Allow network access from chroot environment
sudo cp /etc/resolv.conf $imagedir/etc/
# Fix what I consider to be a bug in vmbuilder
sudo rm -f $imagedir/etc/hostname
# Add multiverse
sudo perl -pi -e '\''s%(universe)$%$1 multiverse%'\'' \
  $imagedir/etc/ec2-init/templates/sources.list.tmpl
# Add Alestic PPA for runurl package (handy in user-data scripts)
echo "deb http://ppa.launchpad.net/alestic/ppa/ubuntu karmic main" |
  sudo tee $imagedir/etc/apt/sources.list.d/alestic-ppa.list
sudo chroot $imagedir \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BE09C571
# Add ubuntu-on-ec2/ec2-tools PPA for updated ec2-ami-tools
echo "deb http://ppa.launchpad.net/ubuntu-on-ec2/ec2-tools/ubuntu karmic main" |
  sudo tee $imagedir/etc/apt/sources.list.d/ubuntu-on-ec2-ec2-tools.list
sudo chroot $imagedir \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9EE6D873
# Upgrade the system and install packages
sudo chroot $imagedir mount -t proc none /proc
sudo chroot $imagedir mount -t devpts none /dev/pts
sudo touch $imagedir/usr/sbin/policy-rc.d
sudo chown ubuntu $imagedir/usr/sbin/policy-rc.d
sudo cat <<EOF > $imagedir/usr/sbin/policy-rc.d
#!/bin/sh
exit 101
EOF
chmod 755 $imagedir/usr/sbin/policy-rc.d
export DEBIAN_FRONTEND=noninteractive
sudo chroot $imagedir apt-get update

sudo -E chroot $imagedir /usr/bin/env LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 apt-get install -y language-pack-en-base

sudo -E chroot $imagedir apt-get dist-upgrade -y &&
sudo -E chroot $imagedir apt-get install -y runurl ec2-ami-tools

# additional packages for building and common dependencies
sudo -E chroot $imagedir apt-get install -y build-essential zlib1g-dev libssl-dev libreadline5-dev
# update one more time
sudo chroot $imagedir apt-get update

sudo chroot $imagedir umount /proc
sudo chroot $imagedir umount /dev/pts
sudo rm -f $imagedir/usr/sbin/policy-rc.d


size=15 # root disk in GB
now=$(date +%Y%m%d-%H%M)
prefix='$newamiprefix'-ubuntu-$release-$codename-$tag-$arch-$now
description="Ubuntu $release $codename $tag $arch $now"
export EC2_CERT=$(echo /mnt/cert-*.pem)
export EC2_PRIVATE_KEY=$(echo /mnt/pk-*.pem)
volumeid=$(ec2-create-volume --size $size --availability-zone us-east-1a |
  cut -f2)
instanceid=$(wget --progress=dot -qO- http://instance-data/latest/meta-data/instance-id)
ec2-attach-volume --device /dev/sdi --instance "$instanceid" "$volumeid"
while [ ! -e /dev/sdi ]; do echo -n .; sleep 1; done
sudo mkfs.ext3 -F /dev/sdi
ebsimage=$imagedir-ebs
sudo mkdir $ebsimage
sudo mount /dev/sdi $ebsimage
sudo tar -cSf - -C $imagedir . | sudo tar xvf - -C $ebsimage
sudo umount $ebsimage
ec2-detach-volume "$volumeid"
snapshotid=$(ec2-create-snapshot "$volumeid" | cut -f2)
ec2-delete-volume "$volumeid"
while ec2-describe-snapshots "$snapshotid" | grep -q pending
  do echo -n .; sleep 1; done
newami=$(ec2-register \
  --architecture $arch \
  --name "$prefix" \
  --description "$description" \
  $ebsopts \
  --snapshot "$snapshotid")
echo "NEW AMI: AMI ID=$newami, EBS ID=$volumeid, EBS SNAPSHOT ID=$snapshotid, PREFIX=$prefix, DESCRIPTION=$description"
'
