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
PACKAGES-$(PTXCONF_EET) += eet

#
# Paths and names
#
EET_VERSION	:= 1.3.2
EET		:= eet-$(EET_VERSION)
EET_SUFFIX	:= tar.bz2
EET_URL		:= http://download.enlightenment.org/releases/$(EET).$(EET_SUFFIX)
EET_SOURCE	:= $(SRCDIR)/$(EET).$(EET_SUFFIX)
EET_DIR		:= $(BUILDDIR)/$(EET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
EET_CONF_TOOL	:= autoconf
EET_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doc

ifdef PTXCONF_EET_GNUTLS
EET_CONF_OPT += --enable-gnutls
else
EET_CONF_OPT += --disable-gnutls
endif

ifdef PTXCONF_EET_OPENSSL
EET_CONF_OPT += --enable-openssl
else
EET_CONF_OPT += --disable-openssl
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/eet.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  eet)
	@$(call install_fixup, eet,PRIORITY,optional)
	@$(call install_fixup, eet,SECTION,base)
	@$(call install_fixup, eet,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, eet,DESCRIPTION,missing)

	@$(call install_lib,   eet, 0, 0, 0644, libeet)

	@$(call install_finish, eet)

	@$(call touch)

# vim: syntax=make
