# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
# 		2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXMLCONFIG) += libxmlconfig

#
# Paths and names
#
LIBXMLCONFIG_VERSION	:= 1.0.8
LIBXMLCONFIG		:= libxmlconfig-$(LIBXMLCONFIG_VERSION)
LIBXMLCONFIG_SUFFIX	:= tar.bz2
LIBXMLCONFIG_URL	:= http://www.pengutronix.de/software/libxmlconfig/download/$(LIBXMLCONFIG).$(LIBXMLCONFIG_SUFFIX)
LIBXMLCONFIG_SOURCE	:= $(SRCDIR)/$(LIBXMLCONFIG).$(LIBXMLCONFIG_SUFFIX)
LIBXMLCONFIG_DIR	:= $(BUILDDIR)/$(LIBXMLCONFIG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBXMLCONFIG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBXMLCONFIG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBXMLCONFIG_PATH	:= PATH=$(CROSS_PATH)
LIBXMLCONFIG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBXMLCONFIG_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxmlconfig.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxmlconfig)
	@$(call install_fixup, libxmlconfig,PRIORITY,optional)
	@$(call install_fixup, libxmlconfig,SECTION,base)
	@$(call install_fixup, libxmlconfig,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libxmlconfig,DESCRIPTION,missing)

	@$(call install_copy, libxmlconfig, 0, 0, 0644, -, \
		/usr/lib/libxmlconfig.so.0.0.0)
	@$(call install_link, libxmlconfig, libxmlconfig.so.0.0.0, \
		/usr/lib/libxmlconfig.so.0)
	@$(call install_link, libxmlconfig, libxmlconfig.so.0.0.0, \
		/usr/lib/libxmlconfig.so)

	@$(call install_finish, libxmlconfig)

	@$(call touch)

# vim: syntax=make
