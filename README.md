# Zonric's Dotfiles

### Herbstluftwm
Configs: ~/.config/herbstluftwm/

##### key binds???

---

### Polybar
<img title="Polybar Screen Shot" alt="Polybar" src="./.dotfiles/Pictures/PolyBar.png">

---

### Downloaded now what?
##### Switch from xrandr script to xorg configs : as of [[a3bde87]](https://github.com/Zonric/dotfiles/commit/a4bde87c1d05a1a7d6d9a98fa969c6f521bd9259)
- 20-amdgpu.conf: sets up amdgpu to use TearFree option (only for AMD GPUs)
- 30-monitors.conf: sets up my triple monitor settings: 

**Files need to be moved to /etc/X11/xorg.conf.d/**

`sudo cp ~/.config/xorg/*.conf /etc/X11/xorg.conf.d/`
