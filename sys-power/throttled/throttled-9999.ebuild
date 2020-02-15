# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_5 python3_6 )

inherit python-single-r1 linux-info systemd git-r3

DESCRIPTION="Fix Intel CPU Throttling on Linux"
HOMEPAGE="https://github.com/erpalma/throttled"
EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_SINGLE_USEDEP}]
	dev-python/pygobject[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${PYTHON_DEPS}"

CONFIG_CHECK="X86_MSR DEVMEM"

pkg_setup() {
	linux-info_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i -e "s/ExecStart=.*/ExecStart=${PN}/" systemd/lenovo_fix.service
}

src_install() {
	default
	python_domodule mmio.py
	python_newscript lenovo_fix.py ${PN}
	dodoc README.md
	insinto /etc/
	doins etc/lenovo_fix.conf
	doinitd "${FILESDIR}"/"${PN}"
	systemd_newunit "${S}/systemd/lenovo_fix.service" "${PN}".service
}
