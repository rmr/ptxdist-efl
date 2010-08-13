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

PACKAGES-$(PTXCONF_EINA) += eina

#
# Paths and names
#
EINA_VERSION  := 0.9.9.49898
EINA          := eina-$(EINA_VERSION)
EINA_SUFFIX   := tar.bz2
EINA_URL      := http://download.enlightenment.org/snapshots/2010-06-27/$(EINA).$(EINA_SUFFIX)
EINA_SOURCE   := $(SRCDIR)/$(EINA).$(EINA_SUFFIX)
EINA_DIR      := $(BUILDDIR)/$(EINA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EINA_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/eina.targetinstall:
	@$(call targetinfo)
	@$(call install_init, eina)
	@$(call install_fixup, eina, PRIORITY, optional)
	@$(call install_fixup, eina, SECTION, base)
	@$(call install_fixup, eina, AUTHOR, "Ryan Raasch <ryan.raasch@gmail.com>")
	@$(call install_fixup, eina, DESCRIPTION, missing)

	@$(call install_lib,  eina, 0, 0, 0644, libeina-ver-svn-06)

	@$(call install_finish,eina)
	@$(call touch)

# vim: syntax=make
