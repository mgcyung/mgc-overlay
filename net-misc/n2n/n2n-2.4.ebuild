# Copyright 1999-2011 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit cmake-utils eutils toolchain-funcs

DESCRIPTION="A Layer Two Peer-to-Peer VPN"
HOMEPAGE="http://www.ntop.org/n2n/"
SRC_URI="https://github.com/ntop/n2n/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup n2n
	enewuser n2n -1 -1 /var/empty n2n
}

src_prepare() {
        eapply_user
	sed -i \
		-e 's|$(CC) $(CFLAGS)|\0 $(LDFLAGS)|' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	# DOCS="HACKING"
	default

	keepdir /var/log/n2n
	fowners n2n:n2n /var/log/n2n

	newconfd "${FILESDIR}/supernode.confd" supernode
	newinitd "${FILESDIR}/supernode.initd" supernode
	newconfd "${FILESDIR}/edge.confd" edge
	newinitd "${FILESDIR}/edge.initd" edge
}

