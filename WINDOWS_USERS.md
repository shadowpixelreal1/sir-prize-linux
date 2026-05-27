# ðª Sir Prize Linux â Guide for Windows Users

Welcome, Windows explorer! This guide walks you through booting or running Sir Prize Linux from your Windows machine.

---

## Option 1: Flash to USB with Rufus (Recommended)

**Best for:** Booting live from USB, or installing to a machine.

1. Download [Rufus](https://rufus.ie) â it's free, tiny, and trustworthy.
2. Insert a USB drive (8GB+ recommended). **Everything on it will be erased.**
3. Open Rufus and:
   - **Device:** select your USB drive
   - **Boot selection:** click **SELECT** and choose `sir-prize-linux.iso`
   - **Partition scheme:** GPT (for modern PCs) or MBR (for older ones)
   - **File system:** FAT32
4. Click **START** â accept the warning â wait a few minutes.
5. Reboot, enter your BIOS/boot menu (usually F12, F2, or Del), and boot from USB.

 Once booted: log in as `user` / password `sirprize` â and type `surprise` in the terminal!

---

## Option 2: Flash to USB with balenaEtcher

**Best for:** Simplest experience, no settings to configure.

1. Download [balenaEtcher](https://etcher.balena.io) â free and cross-platform.
2. Open Etcher and click **Flash from file** â select `sir-prize-linux.iso`.
3. Click **Select target** â choose your USB drive.
4. Click **Flash!** and wait.
5. Reboot and boot from USB via your BIOS boot menu.

---

## Option 3: Run in VirtualBox (No USB needed)

**Best for:** Trying it out without touching your hardware.

1. Download [VirtualBox](https://www.virtualbox.org) and install it.
2. Open VirtualBox â click **New**.
   - **Name:** Sir Prize Linux
   - **Type:** Linux
   - **Version:** Ubuntu (64-bit)
3. Allocate at least **2048 MB RAM** and **20 GB disk** (dynamically allocated is fine).
4. On the **Storage** screen, click the empty CD icon â **Choose a disk file** â select `sir-prize-linux.iso`.
5. Click **Start**!

 Once booted in the VM: log in as `user` / `sirprize` and start exploring Easter eggs.

---

## Option 4: Build the ISO yourself (Advanced)

If you want to build the ISO from source (the scripts in this repo), you'll need a Linux environment. On Windows you can use:

- **WSL2** (Windows Subsystem for Linux): install Ubuntu from the Microsoft Store, then follow `README.md`
- **VirtualBox with Ubuntu 22.04**: spin up a VM, clone this repo inside it, and run `sudo bash build.sh`

---

##  Default Credentials

| Account | Username | Password     |
|---------|----------|--------------|
| User    | `user`   | `sirprize`   |
| Root    | `root`   | `iamroot42`  |

---

##  First Things to Try

Once you're booted, open a terminal and try:

```bash
surprise       # random delight
vibecheck      # fortune + cowsay + lolcat
secret         # classified info
party          # PARTY MODE (Ctrl+C to stop)
answer         # the answer to everything
penguin        # meet Tux
coffee         # you deserve a break
magic          # abracadabra
dance          # choo choo
sudo make me a sandwich   # 
```

Also run: `ls -la ~` for hidden treasure files.

---

*Sir Prize Linux â Every boot is a gift. *
