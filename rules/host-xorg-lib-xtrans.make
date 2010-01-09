# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XTRANS) += host-xorg-lib-xtrans

#
# Paths and names
#
HOST_XORG_LIB_XTRANS_DIR	= $(HOST_BUILDDIR)/$(XORG_LIB_XTRANS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-lib-xtrans.get: $(STATEDIR)/xorg-lib-xtrans.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_LIB_XTRANS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_XTRANS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_XTRANS_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-xtrans_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-xtrans.*
	rm -rf $(HOST_XORG_LIB_XTRANS_DIR)

# vim: syntax=make
