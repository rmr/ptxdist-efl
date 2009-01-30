# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGDBUS) += libgdbus

#
# Paths and names
#
LIBGDBUS_VERSION	:= 0.2
LIBGDBUS		:= libgdbus-$(LIBGDBUS_VERSION)
LIBGDBUS_SUFFIX		:= tar.gz
LIBGDBUS_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBGDBUS).$(LIBGDBUS_SUFFIX)
LIBGDBUS_SOURCE		:= $(SRCDIR)/$(LIBGDBUS).$(LIBGDBUS_SUFFIX)
LIBGDBUS_DIR		:= $(BUILDDIR)/$(LIBGDBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGDBUS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGDBUS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libgdbus.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBGDBUS_DIR))
	@$(call extract, LIBGDBUS)
	@$(call patchin, LIBGDBUS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGDBUS_PATH	:= PATH=$(CROSS_PATH)
LIBGDBUS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGDBUS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-debug \
	--enable-pie \
	--with-gnu-ld

$(STATEDIR)/libgdbus.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBGDBUS_DIR)/config.cache)
	cd $(LIBGDBUS_DIR) && \
		$(LIBGDBUS_PATH) $(LIBGDBUS_ENV) \
		./configure $(LIBGDBUS_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libgdbus.compile:
	@$(call targetinfo)
	cd $(LIBGDBUS_DIR) && $(LIBGDBUS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgdbus.install:
	@$(call targetinfo)
	@$(call install, LIBGDBUS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgdbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgdbus)
	@$(call install_fixup, libgdbus,PACKAGE,libgdbus)
	@$(call install_fixup, libgdbus,PRIORITY,optional)
	@$(call install_fixup, libgdbus,VERSION,$(LIBGDBUS_VERSION))
	@$(call install_fixup, libgdbus,SECTION,base)
	@$(call install_fixup, libgdbus,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libgdbus,DEPENDS,)
	@$(call install_fixup, libgdbus,DESCRIPTION,missing)

	@$(call install_copy, libgdbus, 0, 0, 0644, -, /usr/lib/libgdbus.so.0.0.0)
	@$(call install_link, libgdbus, libgdbus.so.0.0.0, /usr/lib/libgdbus.so.0)
	@$(call install_link, libgdbus, libgdbus.so.0.0.0, /usr/lib/libgdbus.so)

	@$(call install_finish, libgdbus)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgdbus_clean:
	rm -rf $(STATEDIR)/libgdbus.*
	rm -rf $(PKGDIR)/libgdbus_*
	rm -rf $(LIBGDBUS_DIR)

# vim: syntax=make
