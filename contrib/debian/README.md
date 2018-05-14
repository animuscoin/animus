
Debian
====================
This directory contains files used to package animusd/animus-qt
for Debian-based Linux systems. If you compile animusd/animus-qt yourself, there are some useful files here.

## animus: URI support ##


animus-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install animus-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your animus-qt binary to `/usr/bin`
and the `../../share/pixmaps/animus128.png` to `/usr/share/pixmaps`

animus-qt.protocol (KDE)

