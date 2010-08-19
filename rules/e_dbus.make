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
E_DBUS_CONF_OPT := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_E_DBUS_ECONNMAN
E_DBUS_CONF_OPT += --enable-econnman
else
E_DBUS_CONF_OPT += --disable-econnman
endif

ifdef PTXCONF_E_DBUS_EHAL
E_DBUS_CONF_OPT += --enable-ehal
else
E_DBUS_CONF_OPT += --disable-ehal
endif

ifdef PTXCONF_E_DBUS_ENOTIFY
E_DBUS_CONF_OPT += --enable-enotify
else
E_DBUS_CONF_OPT += --disable-enotify
endif

ifdef PTXCONF_E_DBUS_EBLUEZ
E_DBUS_CONF_OPT += --enable-ebluez
else
E_DBUS_CONF_OPT += --disable-ebluez
endif

ifdef PTXCONF_E_DBUS_EOFONO
E_DBUS_CONF_OPT += --enable-eofono
else
E_DBUS_CONF_OPT += --disable-eofono
endif

ifdef PTXCONF_E_DBUS_EUKIT
E_DBUS_CONF_OPT += --enable-eukit
else
E_DBUS_CONF_OPT += --disable-eukit
endif

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

ifdef PTXCONF_E_DBUS_CONNMAN
	@$(call install_lib,   e_dbus, 0, 0, 0644, libeconnman-ver-svn-06)
endif

ifdef PTXCONF_E_DBUS_EHAL
	@$(call install_lib,   e_dbus, 0, 0, 0644, libehal-ver-svn-06)
endif

#ifdef PTXCONF_E_DBUS_ENOTIFY
#	@$(call install_lib,   e_dbus, 0, 0, 0644, libenotify-ver-svn-06)
#endif

ifdef PTXCONF_E_DBUS_BLUEZ
	@$(call install_lib,   e_dbus, 0, 0, 0644, libebluez-ver-svn-06)
endif

ifdef PTXCONF_E_DBUS_EOFONO
	@$(call install_lib,   e_dbus, 0, 0, 0644, libeofono-ver-svn-06)
endif

ifdef PTXCONF_E_DBUS_EUKIT
	@$(call install_lib,   e_dbus, 0, 0, 0644, libeukit-ver-svn-06)
endif

	@$(call install_finish,e_dbus)
	@$(call touch)

# vim: syntax=make
