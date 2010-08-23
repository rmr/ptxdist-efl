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
PACKAGES-$(PTXCONF_ELEMENTARY) += elementary

#
# Paths and names
#
ELEMENTARY_VERSION	:= 0.7.0.49898
ELEMENTARY		:= elementary-$(ELEMENTARY_VERSION)
ELEMENTARY_SUFFIX	:= tar.bz2
ELEMENTARY_URL		:= http://download.enlightenment.org/snapshots/2010-06-27/$(ELEMENTARY).$(ELEMENTARY_SUFFIX)
ELEMENTARY_SOURCE	:= $(SRCDIR)/$(ELEMENTARY).$(ELEMENTARY_SUFFIX)
ELEMENTARY_DIR		:= $(BUILDDIR)/$(ELEMENTARY)
ELEMENTARY_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ELEMENTARY_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
ELEMENTARY_CONF_TOOL	:= autoconf
ELEMENTARY_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doc \
	--disable-ecore-win32 \
	--with-edje-cc=$(PTXCONF_SYSROOT_HOST)/bin/edje_cc \
	--with-eet-eet=$(PTXCONF_SYSROOT_HOST)/bin/eet

ifdef PTXCONF_ELEMENTARY_ECORE_X
ELEMENTARY_CONF_OPT += --enable-ecore-x
else
ELEMENTARY_CONF_OPT += --disable-ecore-x
endif

ifdef PTXCONF_ELEMENTARY_ECORE_FB
ELEMENTARY_CONF_OPT += --enable-ecore-fb
else
ELEMENTARY_CONF_OPT += --disable-ecore-fb
endif

ifdef PTXCONF_ELEMENTARY_ECORE_SDL
ELEMENTARY_CONF_OPT += --enable-ecore-sdl
else
ELEMENTARY_CONF_OPT += --disable-ecore-sdl
endif

ifdef PTXCONF_ELEMENTARY_EDBUS
ELEMENTARY_CONF_OPT += --enable-edbus
else
ELEMENTARY_CONF_OPT += --disable-edbus
endif

ifdef PTXCONF_ELEMENTARY_EFREET
ELEMENTARY_CONF_OPT += --enable-efreet
else
ELEMENTARY_CONF_OPT += --disable-efreet
endif

ifdef PTXCONF_ELEMENTARY_EWEATHER
ELEMENTARY_CONF_OPT += --enable-eweather
else
ELEMENTARY_CONF_OPT += --disable-eweather
endif

ifdef PTXCONF_ELEMENTARY_ETHUMB
ELEMENTARY_CONF_OPT += --enable-ethumb
else
ELEMENTARY_CONF_OPT += --disable-ethumb
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/elementary.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  elementary)
	@$(call install_fixup, elementary,PRIORITY,optional)
	@$(call install_fixup, elementary,SECTION,base)
	@$(call install_fixup, elementary,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, elementary,DESCRIPTION,missing)

	@$(call install_lib, elementary, 0, 0, 0644, libelementary-ver-svn-06)

	@cd $(ELEMENTARY_PKGDIR)/usr/share/elementary && \
	for file in `find . -type f`; do \
		$(call install_copy, elementary, 0, 0, 0644, -, /usr/share/elementary/$$file); \
	done;

	@$(call install_finish, elementary)

	@$(call touch)

# vim: syntax=make
