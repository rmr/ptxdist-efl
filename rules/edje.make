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
PACKAGES-$(PTXCONF_EDJE) += edje

#
# Paths and names
#
EDJE_VERSION	:= 0.9.99.49898
EDJE		:= edje-$(EDJE_VERSION)
EDJE_SUFFIX	:= tar.bz2
EDJE_URL	:= http://download.enlightenment.org/snapshots/2010-06-27/$(EDJE).$(EDJE_SUFFIX)
EDJE_SOURCE	:= $(SRCDIR)/$(EDJE).$(EDJE_SUFFIX)
EDJE_DIR	:= $(BUILDDIR)/$(EDJE)
EDJE_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
EDJE_CONF_TOOL	:= autoconf
EDJE_CONF_OPT	:= \
		$(CROSS_AUTOCONF_USR) \
		--disable-doc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/edje.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  edje)
	@$(call install_fixup, edje,PRIORITY,optional)
	@$(call install_fixup, edje,SECTION,base)
	@$(call install_fixup, edje,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, edje,DESCRIPTION,missing)

	@$(call install_lib, edje, 0, 0, 0644, libedje-ver-svn-06)
	@$(call install_copy, edje, 0, 0, 0755, -, /usr/bin/edje_cc)

	@$(call install_finish, edje)

	@$(call touch)

# vim: syntax=make
