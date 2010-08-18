# -*-makefile-*-
#
# Copyright (C) 2010 by <Ryan Raasch ryan.raasch@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EVAS) += evas

#
# Paths and names
#
EVAS_VERSION	:= 0.9.9.49898
EVAS		:= evas-$(EVAS_VERSION)
EVAS_SUFFIX	:= tar.bz2
EVAS_URL	:= http://download.enlightenment.org/snapshots/2010-06-27/$(EVAS).$(EVAS_SUFFIX)
EVAS_SOURCE	:= $(SRCDIR)/$(EVAS).$(EVAS_SUFFIX)
EVAS_DIR	:= $(BUILDDIR)/$(EVAS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
EVAS_CONF_TOOL	:= autoconf
EVAS_CONF_OPT	:= \
		$(CROSS_AUTOCONF_USR) \
		--disable-doc

ifdef PTXCONF_EVAS_IMAGE_LOADER_EET
EVAS_CONF_OPT += --enable-image-loader-eet
else
EVAS_CONF_OPT += --disable-image-loader-eet
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_FONT
EVAS_CONF_OPT += --enable-font-loader-eet
else
EVAS_CONF_OPT += --disable-font-loader-eet
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_GIF
EVAS_CONF_OPT += --enable-image-loader-gif
else
EVAS_CONF_OPT += --disable-image-loader-gif
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_JPEG
EVAS_CONF_OPT += --enable-image-loader-jpeg
else
EVAS_CONF_OPT += --disable-image-loader-jpeg
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_PMAPS
EVAS_CONF_OPT += --enable-image-loader-pmaps
else
EVAS_CONF_OPT += --disable-image-loader-pmaps
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_PNG
EVAS_CONF_OPT += --enable-image-loader-png
else
EVAS_CONF_OPT += --disable-image-loader-png
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_SVG
EVAS_CONF_OPT += --enable-image-loader-svg
else
EVAS_CONF_OPT += --disable-image-loader-svg
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_TIFF
EVAS_CONF_OPT += --enable-image-loader-tiff
else
EVAS_CONF_OPT += --disable-image-loader-tiff
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_XPM
EVAS_CONF_OPT += --enable-image-loader-xpm
else
EVAS_CONF_OPT += --disable-image-loader-xpm
endif

ifdef PTXCONF_EVAS_IMAGE_LOADER_BMP
EVAS_CONF_OPT += --enable-image-loader-bmp
else
EVAS_CONF_OPT += --disable-image-loader-bmp
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/evas.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  evas)
	@$(call install_fixup, evas,PRIORITY,optional)
	@$(call install_fixup, evas,SECTION,base)
	@$(call install_fixup, evas,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, evas,DESCRIPTION,missing)

	@cd $(EVAS_PKGDIR)/usr/lib/evas/modules && \
	for file in `find . -name '*.so'`; do \
		$(call install_copy, evas, 0, 0, 0644, -, /usr/lib/evas/modules/$$file); \
	done;

	@$(call install_lib, evas, 0, 0, 0644, libevas-ver-svn-06)

	@$(call install_finish, evas)

	@$(call touch)

# vim: syntax=make
