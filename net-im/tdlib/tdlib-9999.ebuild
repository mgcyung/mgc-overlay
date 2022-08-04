# Copyright 1999-2018 Mikhail Klementev
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == *9999 ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/tdlib/td"
        unset SRC_URI
else
        KEYWORDS="~amd64 ~x86"
        SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"

LICENSE="Boost-1.0"
SLOT=0

S="${WORKDIR}/tdlib-${PV}"

src_prepare() {
        # eapply ../patch
        eapply_user

        cmake_src_prepare
}

src_configure() {
        local mycmakeargs=(
                -DCMAKE_INSTALL_PREFIX="/usr"
                -DCMAKE_BUILD_TYPE="Release"
                -DCMAKE_INSTALL_LIBDIR="$(get_libdir)"
        )
        cmake_src_configure
}
