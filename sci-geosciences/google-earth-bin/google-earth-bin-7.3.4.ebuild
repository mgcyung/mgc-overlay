# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# refer to https://github.com/BlueManCZ/edgets/blob/master/sci-geosciences/google-earth-bin/google-earth-bin-7.3.4.ebuild

EAPI=7
inherit desktop unpacker xdg

MY_PN="${PN/-bin/}"
UP_PN="Google Earth Pro"

DESCRIPTION="Explore, search and discover the planet"
HOMEPAGE="https://earth.google.com"
SRC_URI="https://dl.google.com/dl/linux/direct/${MY_PN}-pro-stable_${PV}_amd64.deb -> ${P}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE="alsa"

RDEPEND="dev-libs/expat
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/openssl
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glu
	media-libs/gst-plugins-base
	media-libs/gstreamer
	net-libs/libproxy
	net-print/cups
	sys-apps/dbus
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/libstdc++-v3
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxcb
	x11-misc/xcb
	alsa? ( media-libs/alsa-lib )"

QA_PREBUILT="*"

S=${WORKDIR}

DIR_PATH="google/earth/pro"

src_prepare() {
	default

	rm -rf "opt/${DIR_PATH}/libcrypto.so.1.0.0" || die "rm failed"
	rm -rf "opt/${DIR_PATH}/libexpat.so.1" || die "rm failed"
	rm -rf "opt/${DIR_PATH}/libssl.so.1.0.0" || die "rm failed"
	rm -rf "etc/cron.daily" || die "rm failed"
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	dosym "/opt/${DIR_PATH}/googleearth" "/usr/bin/google-earth" || die "dosym failed"

	newicon "opt/${DIR_PATH}/product_logo_256.png" "${MY_PN}.png"

	make_desktop_entry "${MY_PN}" "${UP_PN}" "${MY_PN}" "Education;Network;Science" "GenericName=3D planet viewer\n\
StartupWMClass=${UP_PN}\nMimeType=application/vnd.google-earth.kml+xml;\
application/vnd.google-earth.kmz;application/earthviewer;application/keyhole"
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Google Earth is licensed under its own license available here: https://earth.google.com/intl/en/licensepro.html"
}
