# The ebuild is now in the official tree!

# throttled-overlay

Gentoo Portage overlay for the [throttled](https://github.com/erpalma/throttled) tool.

## Adding the overlay

### Via eselect (recommended)

Since portage 2.2, [eselect repository](https://wiki.gentoo.org/wiki/Eselect/Repository) allows easy management of the Gentoo repositories. If you have it not yet installed, you can do so via `emerge --ask app-eselect/eselect-repository`.
To add the repository just run:

	eselect repository add throttled git https://github.com/erpalma/throttled-overlay.git

### Via manual configuration of local overlays

[Local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and create a `/etc/portage/repos.conf/throttled-overlay.conf` file containing precisely:

```
[throttled]
location = /usr/local/portage/throttled
sync-type = git
sync-uri = https://github.com/erpalma/throttled-overlay.git
priority = 9999
```

### Via layman

Invoke the following:

	layman -o https://github.com/erpalma/throttled-overlay/raw/master/repositories.xml -f -a throttled
	
Or read the instructions on the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Layman#Adding_custom_repositories).

## Syncing

You can sync all your repositories via `emaint sync -a` or  `emerge --sync`. After that, the ebuilds should be available for installation.

# Installation

Depending on your setup, you might need to accept a keyword for this pacakge by adding it to `/etc/portage/package.accept_keywords`. See [Gentoo Wiki](https://wiki.gentoo.org/wiki/Knowledge_Base:Accepting_a_keyword_for_a_single_package).
Then you can install it like this:

	sudo emerge -av sys-power/throttled
