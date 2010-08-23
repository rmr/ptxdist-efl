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
HOST_PACKAGES-$(PTXCONF_HOST_EDJE) += host-edje

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_EDJE_CONF_TOOL	:= autoconf
HOST_EDJE_CONF_OPT	:= $(HOST_AUTOCONF)

# vim: syntax=make
