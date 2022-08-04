# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Mob is for ximalaya"
HOMEPAGE="https://github.com/zenghongtu/Mob"

KEYWORDS="~amd64 ~x86"
SRC_URI="
		amd64? ( https://github.com/zenghongtu/Mob/releases/download/v${PV}/${PN}-${PV}-linux-amd64.deb )
"

SLOT="0"
IUSE=""

S="${WORKDIR}"

src_unpack() {
    default_src_unpack
    unpack ./data.tar.xz
}

src_install() {
    insinto /opt
    doins -r "${S}"/opt/Mob
    insinto /opt/usr/share
    doins -r "${S}"/usr/share/
    dodir /opt/bin
    dosym /opt/Mob/mob /opt/bin/mob
    fperms 0755 /opt/Mob/mob
}
