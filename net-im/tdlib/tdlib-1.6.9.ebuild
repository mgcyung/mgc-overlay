# Copyright 1999-2018 Mikhail Klementev
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

EGIT_REPO_URI="https://github.com/tdlib/td"
EGIT_COMMIT="30921606c5a5ea4c31193adcbb457cce4503751d"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"

LICENSE="Boost-1.0"
SLOT=0

S="${WORKDIR}/tdlib-${PV}"

src_prepare() {
        # eapply ../patch
        eapply_user

        cmake-utils_src_prepare
}

src_configure() {
        local mycmakeargs=(
                -DCMAKE_INSTALL_PREFIX="/usr"
                -DCMAKE_BUILD_TYPE="Release"
                -DCMAKE_INSTALL_LIBDIR="$(get_libdir)"
        )
        cmake-utils_src_configure
}
