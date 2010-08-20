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
PACKAGES-$(PTXCONF_EMBRYO) += embryo

#
# Paths and names
#
EMBRYO_VERSION	:= 0.9.9.49898
EMBRYO		:= embryo-$(EMBRYO_VERSION)
EMBRYO_SUFFIX	:= tar.bz2
EMBRYO_URL	:= http://download.enlightenment.org/snapshots/2010-06-27/$(EMBRYO).$(EMBRYO_SUFFIX)
EMBRYO_SOURCE	:= $(SRCDIR)/$(EMBRYO).$(EMBRYO_SUFFIX)
EMBRYO_DIR	:= $(BUILDDIR)/$(EMBRYO)
EMBRYO_LICENSE	:= ZLIB

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
EMBRYO_CONF_TOOL:= autoconf
EMBRYO_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-doc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/embryo.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  embryo)
	@$(call install_fixup, embryo,PRIORITY,optional)
	@$(call install_fixup, embryo,SECTION,base)
	@$(call install_fixup, embryo,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, embryo,DESCRIPTION,missing)

	@$(call install_lib, embryo, 0, 0, 0644, libembryo-ver-svn-06)

	@$(call install_finish, embryo)

	@$(call touch)

# vim: syntax=make
