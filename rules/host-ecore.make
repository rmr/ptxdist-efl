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
HOST_PACKAGES-$(PTXCONF_HOST_ECORE) += host-ecore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_ECORE_CONF_TOOL	:= autoconf
HOST_ECORE_CONF_OPT	:= \
		$(HOST_AUTOCONF) \
		--enable-ecore-evas \
		--enable-ecore-imf \
		--enable-ecore-imf-evas \
		--enable-ecore-file \
		--enable-ecore-con \
		--enable-ecore-x-input \
		--disable-ecore-config

# vim: syntax=make
