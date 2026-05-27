#!/usr/bin/env bash
# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
# â           Sir Prize Linux â ISO Build Script                    â
# â           "Every Boot is a Gift "                             â
# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
#
# Requirements:
#   - Ubuntu 22.04 (Jammy) host machine
#   - At least 20 GB free disk space
#   - Root / sudo access
#   - Internet connection
#
# Usage:
#   chmod +x build.sh
#   sudo ./build.sh
#
# Output:
#   sir-prize-linux-1.0.iso  (in the current directory)

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ISO_NAME="sir-prize-linux-1.0"
BUILD_DIR="$SCRIPT_DIR/build"

# ââ Colors ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'
MAG='\033[0;35m'; CYN='\033[0;36m'; RST='\033[0m'

log()  { echo -e "${CYN}[BUILD]${RST} $*"; }
ok()   { echo -e "${GRN}[ OK  ]${RST} $*"; }
warn() { echo -e "${YLW}[WARN ]${RST} $*"; }
die()  { echo -e "${RED}[FAIL ]${RST} $*"; exit 1; }

# ââ Pre-flight checks âââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
[[ $EUID -ne 0 ]] && die "This script must be run as root (use sudo)."

# Check Ubuntu 22.04
if ! grep -q "jammy" /etc/os-release 2>/dev/null; then
    warn "Host OS is not Ubuntu 22.04 Jammy. Build may still work but is untested."
fi

# Check disk space (need ~20 GB)
AVAIL_KB=$(df --output=avail "$SCRIPT_DIR" | tail -1)
if (( AVAIL_KB < 20971520 )); then
    warn "Less than 20 GB free space. Build may fail. Available: $(( AVAIL_KB / 1024 / 1024 )) GB"
    read -p "Continue anyway? [y/N] " -n1 REPLY; echo
    [[ "$REPLY" =~ [Yy] ]] || exit 1
fi

echo ""
echo -e "${MAG}"
cat << 'BANNER'
   _____ _       ____       _
  / ____(_)     |  _ \     (_)
 | (___  _ _ __ | |_) |_ __ _ _______  ___
  \___ \| | '__||  __/| '__| |_  /  _\/ _ \
  ____) | | |   | |   | |  | |/ /  __/  __/
 |_____/|_|_|   |_|   |_|  |_/___\___|\___|

          Building the ISO...  
BANNER
echo -e "${RST}"

# ââ Install dependencies ââââââââââââââââââââââââââââââââââââââââââââââââââââââ
log "Installing build dependencies..."
apt-get update -qq
apt-get install -y --no-install-recommends \
    live-build \
    debootstrap \
    squashfs-tools \
    xorriso \
    isolinux \
    syslinux-common \
    grub-pc-bin \
    grub-efi-amd64-bin \
    mtools \
    dosfstools \
    git \
    curl \
    wget \
    lolcat \
    figlet \
    2>/dev/null
ok "Dependencies installed."

# ââ Set up build directory ââââââââââââââââââââââââââââââââââââââââââââââââââââ
log "Preparing build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# ââ Initialize live-build âââââââââââââââââââââââââââââââââââââââââââââââââââââ
log "Initializing live-build config..."
lb config \
    --distribution jammy \
    --archive-areas "main restricted universe multiverse" \
    --architectures amd64 \
    --mirror-bootstrap http://archive.ubuntu.com/ubuntu/ \
    --mirror-chroot http://archive.ubuntu.com/ubuntu/ \
    --mirror-binary http://archive.ubuntu.com/ubuntu/ \
    --bootloaders "grub-pc,grub-efi" \
    --debian-installer none \
    --hostname sirprize \
    --username user \
    --iso-application "Sir Prize Linux" \
    --iso-volume "SirPrize_1.0" \
    --bootappend-live "boot=live components quiet splash username=user hostname=sirprize" \
    --parent-distribution jammy \
    --parent-archive-areas "main restricted universe multiverse" \
    2>&1 | tail -5
ok "live-build initialized."

# ââ Copy our customizations âââââââââââââââââââââââââââââââââââââââââââââââââââ
log "Copying customization files..."

# Package list
mkdir -p config/package-lists
cp "$SCRIPT_DIR/config/package-lists/fun.list.chroot" config/package-lists/

# Hooks
mkdir -p config/hooks/live
cp "$SCRIPT_DIR/config/hooks/live/"* config/hooks/live/
chmod +x config/hooks/live/*.hook.chroot

# Includes (files to drop into the chroot)
log "Copying filesystem includes..."
# We copy the includes.chroot subtree into live-build's expected location
rsync -a "$SCRIPT_DIR/includes.chroot/" config/includes.chroot/ 2>/dev/null || \
    cp -rp "$SCRIPT_DIR/includes.chroot/." config/includes.chroot/
ok "Files copied."

# ââ Build! ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
log "Starting build â this will take 20-40 minutes "
log "Go make yourself a coffee: $ coffee"
echo ""

# Capture start time
START=$(date +%s)

lb build 2>&1 | tee "$BUILD_DIR/build.log"

END=$(date +%s)
ELAPSED=$(( END - START ))
MINS=$(( ELAPSED / 60 ))
SECS=$(( ELAPSED % 60 ))

echo ""
ok "Build completed in ${MINS}m ${SECS}s!"

# ââ Find and rename the ISO âââââââââââââââââââââââââââââââââââââââââââââââââââ
ISO_SRC=$(find "$BUILD_DIR" -name "*.iso" | head -1)
if [[ -z "$ISO_SRC" ]]; then
    die "No ISO found after build. Check build.log for errors."
fi

ISO_DEST="$SCRIPT_DIR/${ISO_NAME}.iso"
mv "$ISO_SRC" "$ISO_DEST"

ISO_SIZE=$(du -sh "$ISO_DEST" | cut -f1)
ok "ISO ready: $ISO_DEST ($ISO_SIZE)"

# ââ Print final summary âââââââââââââââââââââââââââââââââââââââââââââââââââââââ
echo ""
echo -e "${MAG}"
cat << 'DONE'
  âââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
  â                                                       â
  â     Sir Prize Linux ISO built successfully!       â
  â                                                       â
  â  To test:                                             â
  â    qemu-system-x86_64 -m 2048 -cdrom sir-prize-*.iso  â
  â    (install qemu-system-x86 first)                   â
  â                                                       â
  â  To flash to USB:                                     â
  â    sudo dd if=sir-prize-*.iso of=/dev/sdX bs=4M       â
  â    (replace /dev/sdX with your USB drive!)            â
  â                                                       â
  â  Default login:  user / sirprize                      â
  â  Root password:  iamroot42                            â
  â                                                       â
  âââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
DONE
echo -e "${RST}"
