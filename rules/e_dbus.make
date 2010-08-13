# -*-makefile-*-
#
# Copyright (C) 2007 by Lars Munch <lars@segv.dk>
#		2010 by Ryan Raasch <ryan.raasch@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_E_DBUS) += e_dbus

#
# Paths and names
#
E_DBUS_VERSION  := 0.5.0.49898
E_DBUS          := e_dbus-$(E_DBUS_VERSION)
E_DBUS_SUFFIX   := tar.bz2
E_DBUS_URL      := http://download.enlightenment.org/snapshots/2010-06-27/$(E_DBUS).$(E_DBUS_SUFFIX)
E_DBUS_SOURCE   := $(SRCDIR)/$(E_DBUS).$(E_DBUS_SUFFIX)
E_DBUS_DIR      := $(BUILDDIR)/$(E_DBUS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

E_DBUS_CONF_TOOL := autoconf

E_DBUS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-econnman \
	--disable-ehal \
	--disable-enotify \
	--disable-ebluez \
	--disable-eofono \
	--disable-eukit

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/e_dbus.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  e_dbus)
	@$(call install_fixup, e_dbus, PRIORITY, optional)
	@$(call install_fixup, e_dbus, SECTION, base)
	@$(call install_fixup, e_dbus, AUTHOR, "Ryan Raasch <ryan.raasch@gmail.com>")
	@$(call install_fixup, e_dbus, DESCRIPTION, missing)

	@$(call install_lib,   e_dbus, 0, 0, 0644, libedbus-ver-svn-06)

	@$(call install_finish,e_dbus)
	@$(call touch)

# vim: syntax=make
