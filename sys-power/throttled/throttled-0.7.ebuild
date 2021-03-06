# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 linux-info systemd

DESCRIPTION="Fix Intel CPU Throttling on Linux"
HOMEPAGE="https://github.com/erpalma/throttled"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
	EGIT_BRANCH="master"
else
	MY_P="v${PV}"
	SRC_URI="https://github.com/erpalma/${PN}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_MULTI_USEDEP}]
		dev-python/pygobject[${PYTHON_MULTI_USEDEP}]
	')
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
