#  Sir Prize Linux v1.0 â *Pandora's Box Edition*

> **"Every boot is a gift."**

Sir Prize Linux is a custom Ubuntu-based live distro packed with hidden Easter eggs,
fun terminal commands, surprise animations, and enough whimsy to make your inner
penguin smile. It's based on **Ubuntu 22.04 LTS (Jammy)** with XFCE desktop.

---

##  Building the ISO

### Requirements
| Thing | Min |
|-------|-----|
| Host OS | Ubuntu 22.04 LTS |
| Free disk | 20 GB |
| RAM | 4 GB |
| Internet | Yes |
| Permissions | Root / sudo |

### One-command build
```bash
git clone <this-repo>
cd sir-prize-linux
sudo ./build.sh
```

The build takes ~20â40 minutes. The output ISO will be named `sir-prize-linux-1.0.iso`.

---

##  Testing the ISO

**QEMU (fastest):**
```bash
sudo apt install qemu-system-x86
qemu-system-x86_64 -m 2048 -cdrom sir-prize-linux-1.0.iso -boot d
```

**VirtualBox:**
1. New VM â Linux â Ubuntu 64-bit
2. 2+ GB RAM, no hard disk needed
3. Settings â Storage â attach the ISO
4. Boot!

**Real hardware (USB):**
```bash
# Replace /dev/sdX with YOUR USB drive â double-check with lsblk!
sudo dd if=sir-prize-linux-1.0.iso of=/dev/sdX bs=4M status=progress
sudo sync
```

---

##  Default Credentials

| Account | Password |
|---------|----------|
| `user` | `sirprize` |
| `root` | `iamroot42` |

---

##  What's Hidden Inside

### Terminal Easter Eggs
Type these commands in any terminal:

| Command | What happens |
|---------|-------------|
| `surprise` | Random delight â one of 9 possible surprises |
| `coffee` | ASCII coffee art + programming haiku |
| `magic` | `figlet ABRACADABRA \| lolcat` + fortune |
| `secret` | Reveals the secret file map |
| `party` | cmatrix in magenta party mode |
| `answer` | The answer to life, the universe, and everything |
| `penguin` | Meet Tux with a random quip |
| `vibecheck` | `fortune \| cowsay -f tux \| lolcat` |
| `dance` | Steam locomotive (sl) across the screen |
| `matrix` | `cmatrix -s -b` |
| `choo` | Alias for `dance` |
| `hug` | You need a hug  |
| `dontpanic` | `figlet "DON'T PANIC" \| lolcat` |
| `vibecheck` | Check those vibes |

### The sudo Sandwich
```bash
sudo make me a sandwich
```
It works. Really.

### Command Counter
Every **42nd command** you run earns a fortune cookie reward.

### First Login
The very first time you log in, a special welcome message appears revealing
the existence of hidden secrets.

### Hidden Files in `~`
```
ls -la ~
```
Look for:
- `~/.treasure` â the treasure chest (start here)
- `~/.secret_menu` â complete Easter egg guide
- `~/.surprise_box/` â a box with riddles, poems, and the answer
  - `riddle.txt` â 4 riddles
  - `answer.txt` â the real answer (42)
  - `poem.txt` â The Ballad of Sir Prize

### Vim Easter Eggs
Inside vim:
- `:Surprise` â fortune + cowsay + lolcat
- `:Coffee` â you know what it does
- `:Magic` â abracadabra

### Hidden Root File
```bash
sudo cat /etc/.the_answer
```

### The Pong Game
```bash
/usr/local/games/pong.sh
```

### The Rainbow Prompt
The terminal prompt is a beautiful ` user@host:~/path âº` in purple/cyan/gold.

---

##  Visual Touches

- **Wallpaper**: Custom SVG space/nebula scene with a glowing gift box, stars, and shooting stars
- **Terminal**: Dracula-inspired color scheme (purple background, neon accents)
- **GRUB**: Sir Prize Linux branding, 8-second timeout with color theme
- **Login screen**: ASCII art title + hint about secrets
- **MOTD**: Full ASCII logo + list of Easter egg commands
- **Neofetch**: Runs on login, shows system info with custom styling
- **Boot**: Plymouth text splash with dark purple background

---

##  Pre-installed Packages

**Fun stuff:** cowsay, fortune-mod, fortunes, figlet, lolcat, cmatrix, sl, toilet, libaa-bin, nyancat (built from source), asciiquarium

**Games:** bsdgames, ninvaders, bastet (Tetris), nsnake, pacman4console, moon-buggy

**System tools:** neofetch, htop, ncdu, tree, tmux, screen, vim

**Dev:** git, curl, wget, python3, nodejs, npm, build-essential

**Desktop:** XFCE4, Firefox, network-manager, LightDM

**Themes:** Papirus icons, Arc theme, Noto fonts + emoji + Powerline fonts

---

##  Repository Structure

```
sir-prize-linux/
âââ build.sh                          # â RUN THIS
âââ README.md                         # You are here
âââ config/
â   âââ bootstrap                     # live-build bootstrap config
â   âââ common                        # live-build common config
â   âââ binary                        # live-build binary/ISO config
â   âââ package-lists/
â   â   âââ fun.list.chroot           # packages to install
â   âââ hooks/live/
â       âââ 0010-sirprize-setup.hook.chroot   # main customization
â       âââ 0020-plymouth-and-final.hook.chroot
âââ includes.chroot/                  # files dropped into the live system
    âââ etc/
    â   âââ motd                      # message of the day
    â   âââ issue                     # pre-login ASCII banner
    â   âââ os-release                # distro identity
    â   âââ default/grub              # GRUB config
    â   âââ grub.d/05_sirprize_header # GRUB menu header
    â   âââ profile.d/
    â   â   âââ sirprize-welcome.sh   # login welcome + quotes
    â   âââ skel/                     # template for new user homes
    â       âââ .bashrc               # rainbow prompt + sandwich Easter egg
    â       âââ .bash_aliases         # fun aliases
    â       âââ .treasure             # hidden treasure file
    â       âââ .secret_menu          # secret command list
    â       âââ .surprise_box/        # surprise box contents
    â       â   âââ riddle.txt
    â       â   âââ answer.txt
    â       â   âââ poem.txt
    â       âââ .config/
    â           âââ neofetch/config.conf
    âââ usr/
        âââ local/bin/                # Easter egg commands
        â   âââ surprise, coffee, magic, secret
        â   âââ party, answer, penguin, vibecheck, dance
        â   âââ (pong in /usr/local/games/)
        âââ share/backgrounds/sir-prize/
            âââ wallpaper.svg         # custom space wallpaper
```

---

##  Troubleshooting

**Build fails with "Chroot failed":**
Make sure you have internet access and at least 20 GB free.

**Plymouth theme not showing:**
Normal on some VMs â text mode will fall back gracefully.

**Missing nyancat:**
Nyancat is built from source during the hook. If GitHub is unreachable during build,
it won't be installed but everything else will work fine.

**Want to rebuild cleanly:**
```bash
sudo lb clean --purge
sudo ./build.sh
```

---

##  Credits

Built with love, `live-build`, and an unhealthy obsession with ASCII art.
Based on Ubuntu 22.04 LTS. Tux approves.

*Sir Prize Linux â because computers should be fun.*
