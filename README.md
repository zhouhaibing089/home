home
====

I don't want to do all of customization again and again:

1. tmux configurations and themes.
1. vim configurations and themes.
1. installed brew packages.

## Map Caps to Ctrl

Install `keyd` package with:

```console
$ pacman -S keyd
$ systemctl enable --now keyd
```

Then add the following configuration in `/etc/keyd/default.conf`:

```ini
[ids]
*

[main]
capslock = overload(control, capslock)
```

On macOS:

System Settings -> Keyboard -> Keyboard Shortcuts -> Modifier Keys
