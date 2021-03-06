# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEVENT) += libevent

#
# Paths and names
#
LIBEVENT_VERSION	:= 2.0.4-alpha
LIBEVENT		:= libevent-$(LIBEVENT_VERSION)
LIBEVENT_SUFFIX		:= tar.gz
LIBEVENT_URL		:= http://www.monkey.org/~provos/$(LIBEVENT).$(LIBEVENT_SUFFIX)
LIBEVENT_SOURCE		:= $(SRCDIR)/$(LIBEVENT).$(LIBEVENT_SUFFIX)
LIBEVENT_DIR		:= $(BUILDDIR)/$(LIBEVENT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBEVENT_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBEVENT)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEVENT_PATH	:= PATH=$(CROSS_PATH)
LIBEVENT_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBEVENT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libevent.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libevent)
	@$(call install_fixup, libevent,PRIORITY,optional)
	@$(call install_fixup, libevent,SECTION,base)
	@$(call install_fixup, libevent,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libevent,DESCRIPTION,missing)

	@$(call install_copy, libevent, 0, 0, 0644, -, \
		/usr/lib/libevent.so.3.0.0)
	@$(call install_link, libevent, libevent.so.3.0.0, /usr/lib/libevent.so.3)
	@$(call install_link, libevent, libevent.so.3.0.0, /usr/lib/libevent.so)

	@$(call install_finish, libevent)

	@$(call touch)

# vim: syntax=make
