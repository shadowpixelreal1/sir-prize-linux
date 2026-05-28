#  Sir Prize Linux v1.0 -- *Pandora's Box Edition*

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

The build takes ~20-40 minutes. The output ISO will be named `sir-prize-linux-1.0.iso`.

---

##  Testing the ISO

**QEMU (fastest):**
```bash
sudo apt install qemu-system-x86
qemu-system-x86_64 -m 2048 -cdrom sir-prize-linux-1.0.iso -boot d
```

**VirtualBox:**
1. New VM -> Linux -> Ubuntu 64-bit
2. 2+ GB RAM, no hard disk needed
3. Settings -> Storage -> attach the ISO
4. Boot!

**Real hardware (USB):**
```bash
# Replace /dev/sdX with YOUR USB drive -- double-check with lsblk!
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
| `surprise` | Random delight -- one of 9 possible surprises |
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
- `~/.treasure` -- the treasure chest (start here)
- `~/.secret_menu` -- complete Easter egg guide
- `~/.surprise_box/` -- a box with riddles, poems, and the answer
  - `riddle.txt` -- 4 riddles
  - `answer.txt` -- the real answer (42)
  - `poem.txt` -- The Ballad of Sir Prize

### Vim Easter Eggs
Inside vim:
- `:Surprise` -- fortune + cowsay + lolcat
- `:Coffee` -- you know what it does
- `:Magic` -- abracadabra

### Hidden Root File
```bash
sudo cat /etc/.the_answer
```

### The Pong Game
```bash
/usr/local/games/pong.sh
```

### The Rainbow Prompt
The terminal prompt is a beautiful ` user@host:~/path ?` in purple/cyan/gold.

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
|-- build.sh                          # <- RUN THIS
|-- README.md                         # You are here
|-- config/
|   |-- bootstrap                     # live-build bootstrap config
|   |-- common                        # live-build common config
|   |-- binary                        # live-build binary/ISO config
|   |-- package-lists/
|   |   \-- fun.list.chroot           # packages to install
|   \-- hooks/live/
|       |-- 0010-sirprize-setup.hook.chroot   # main customization
|       \-- 0020-plymouth-and-final.hook.chroot
\-- includes.chroot/                  # files dropped into the live system
    |-- etc/
    |   |-- motd                      # message of the day
    |   |-- issue                     # pre-login ASCII banner
    |   |-- os-release                # distro identity
    |   |-- default/grub              # GRUB config
    |   |-- grub.d/05_sirprize_header # GRUB menu header
    |   |-- profile.d/
    |   |   \-- sirprize-welcome.sh   # login welcome + quotes
    |   \-- skel/                     # template for new user homes
    |       |-- .bashrc               # rainbow prompt + sandwich Easter egg
    |       |-- .bash_aliases         # fun aliases
    |       |-- .treasure             # hidden treasure file
    |       |-- .secret_menu          # secret command list
    |       |-- .surprise_box/        # surprise box contents
    |       |   |-- riddle.txt
    |       |   |-- answer.txt
    |       |   \-- poem.txt
    |       \-- .config/
    |           \-- neofetch/config.conf
    \-- usr/
        |-- local/bin/                # Easter egg commands
        |   |-- surprise, coffee, magic, secret
        |   |-- party, answer, penguin, vibecheck, dance
        |   \-- (pong in /usr/local/games/)
        \-- share/backgrounds/sir-prize/
            \-- wallpaper.svg         # custom space wallpaper
```

---

##  Troubleshooting

**Build fails with "Chroot failed":**
Make sure you have internet access and at least 20 GB free.

**Plymouth theme not showing:**
Normal on some VMs -- text mode will fall back gracefully.

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

*Sir Prize Linux -- because computers should be fun.*
