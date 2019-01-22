# throttled-overlay

Gentoo Portage overlay for the [throttled](https://github.com/erpalma/throttled) tool.

## local overlays

[Local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and create a `/etc/portage/repos.conf/throttled-overlay.conf` file containing precisely:

```
[throttled]
location = /usr/local/portage/throttled
sync-type = git
sync-uri = https://github.com/erpalma/throttled-overlay.git
priority = 9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make the ebuilds available.

## layman

Invoke the following:

	layman -o https://github.com/erpalma/throttled-overlay/raw/master/repositories.xml -f -a throttled
	
Or read the instructions on the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Layman#Adding_custom_repositories).

# Installation

After performing those steps, the following should work:

	sudo emerge -av sys-power/throttled
