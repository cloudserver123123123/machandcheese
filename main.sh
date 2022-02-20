#Script to run Mac OS 10.3 on Replit
#By @UniqueOstrich18 on replit.com
#https://replit.com/@UniqueOstrich18/MaxOSX

if ! command -v qemu-system-i386 &> /dev/null
then
  echo "QEMU not installed, installing now..."
  sleep 2
  install-pkg qemu htop
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/libraries

FILE=/tmp/macos.qcow2
if test -f "$FILE"; then
  printf "\nHard disk file already present, skipping download.\n"
else 
  printf "\nInstalling gdown...\n"
  pip3 --disable-pip-version-check install gdown -q
  printf "\nDownloading hard disk image...\n"
  gdown https://drive.google.com/u/0/uc?id=1yreQNU91s7ztr7PSG2HaiA3w-vgtjWnh -O /tmp/macos.qcow2
fi

cd resources
printf "\nStarting system...\n"

#QEMU Command goes below
qemu-system-ppc -L pc-bios -boot c -M mac99 -m 256 -drive file=/tmp/macos.qcow2,format=qcow2,media=disk -device usb-kbd -device usb-mouse