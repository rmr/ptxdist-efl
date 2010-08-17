# -*-makefile-*-
#
# Copyright (C) 2007 by Lars Munch <lars@segv.dk>
#               2010 by Ryan Raasch <ryan.raasch@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_ECORE) += ecore

#
# Paths and names
#
ECORE_VERSION  := 0.9.9.49898
ECORE          := ecore-$(ECORE_VERSION)
ECORE_SUFFIX   := tar.bz2
ECORE_URL      := http://download.enlightenment.org/snapshots/2010-06-27/$(ECORE).$(ECORE_SUFFIX)
ECORE_SOURCE   := $(SRCDIR)/$(ECORE).$(ECORE_SUFFIX)
ECORE_DIR      := $(BUILDDIR)/$(ECORE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ECORE_CONF_TOOL := autoconf

ECORE_CONF_OPT = \
	$(CROSS_AUTOCONF_USR) \
	--disable-ecore-file \
	--disable-ecore-con \
	--disable-ecore-config \
	--disable-abstract-sockets \
	--disable-ecore-imf

ifdef PTXCONF_ECORE_SSL
ECORE_CONF_OPT += --enable-openssl
endif

ifndef PTXCONF_ECORE_ENABLE_INPUT
ECORE_CONF_OPT += --disable-ecore-input
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ecore.targetinstall:
	@$(call targetinfo)
	@$(call install_init, ecore)
	@$(call install_fixup, ecore, PRIORITY, optional)
	@$(call install_fixup, ecore, SECTION, base)
	@$(call install_fixup, ecore, AUTHOR, "Ryan Raasch <ryan.raasch@gmail.com>")
	@$(call install_fixup, ecore, DESCRIPTION, missing)

	@$(call install_lib,  ecore, 0, 0, 0644, libecore-ver-svn-06)

	@$(call install_finish, ecore)
	@$(call touch)

# vim: syntax=make
