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
HOST_PACKAGES-$(PTXCONF_HOST_LIBJPEG) += host-libjpeg

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBJPEG_CONF_TOOL	:= autoconf
HOST_LIBJPEG_CONF_OPT	:= $(HOST_AUTOCONF)

# vim: syntax=make
