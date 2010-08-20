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
PACKAGES-$(PTXCONF_EFREET) += efreet

#
# Paths and names
#
EFREET_VERSION	:= 0.5.0.49898
EFREET		:= efreet-$(EFREET_VERSION)
EFREET_SUFFIX	:= tar.bz2
EFREET_URL	:= http://download.enlightenment.org/snapshots/2010-06-27/$(EFREET).$(EFREET_SUFFIX)
EFREET_SOURCE	:= $(SRCDIR)/$(EFREET).$(EFREET_SUFFIX)
EFREET_DIR	:= $(BUILDDIR)/$(EFREET)
EFREET_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
EFREET_CONF_TOOL	:= autoconf
EFREET_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/efreet.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  efreet)
	@$(call install_fixup, efreet,PRIORITY,optional)
	@$(call install_fixup, efreet,SECTION,base)
	@$(call install_fixup, efreet,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, efreet,DESCRIPTION,missing)

	@$(call install_lib, efreet, 0, 0, 0644, libefreet-ver-svn-06)

	@$(call install_finish, efreet)

	@$(call touch)

# vim: syntax=make
