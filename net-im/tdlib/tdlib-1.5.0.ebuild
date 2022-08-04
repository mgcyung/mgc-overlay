# Copyright 1999-2018 Mikhail Klementev
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT=0
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/td-${PV}"

src_prepare() {
        # eapply ../patch
        epatch ${FILESDIR}/${P}-gentoo-multilib-strict.patch
        eapply_user

        cmake_src_prepare
}
