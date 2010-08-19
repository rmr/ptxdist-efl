# -*-makefile-*-
#
# Copyright (C) 2007 by Lars Munch <lars@segv.dk>
#               2010 by Ryan Raasch <ryan.raasch@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_ECORE) += ecore

#
# Paths and names
#
ECORE_VERSION  := 0.9.9.49898
ECORE          := ecore-$(ECORE_VERSION)
ECORE_SUFFIX   := tar.bz2
ECORE_URL      := http://download.enlightenment.org/snapshots/2010-06-27/$(ECORE).$(ECORE_SUFFIX)
ECORE_SOURCE   := $(SRCDIR)/$(ECORE).$(ECORE_SUFFIX)
ECORE_DIR      := $(BUILDDIR)/$(ECORE)
ECORE_LICENSE  := BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ECORE_CONF_TOOL := autoconf

ECORE_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-ecore-evas-cocoa \
	--disable-ecore-evas-software-gdi \
	--disable-ecore-evas-software-ddraw \
	--disable-ecore-evas-software-16-ddraw \
	--disable-ecore-evas-software-16-wince \
	--disable-doc

ifdef PTXCONF_ECORE_XTEST
ECORE_CONF_OPT += --enable-ecore-x-xtest
else
ECORE_CONF_OPT += --disable-ecore-x-xtest
endif

ifdef PTXCONF_ECORE_FILE
ECORE_CONF_OPT += --enable-ecore-file
else
ECORE_CONF_OPT += --disable-ecore-file
endif

ifdef PTXCONF_ECORE_CON
ECORE_CONF_OPT += --enable-ecore-con
else
ECORE_CONF_OPT += --disable-ecore-con
endif

ifdef PTXCONF_ECORE_SSL
ECORE_CONF_OPT += --enable-openssl
else
ECORE_CONF_OPT += --disable-openssl
endif

ifdef PTXCONF_ECORE_XINPUT
ECORE_CONF_OPT += --enable-ecore-x-input
else
ECORE_CONF_OPT += --disable-ecore-x-input
endif

ifndef PTXCONF_ECORE_TESTS
ECORE_CONF_OPT += --enable-tests
else
ECORE_CONF_OPT += --disable-tests
endif

ifdef PTXCONF_ECORE_CURL
ECORE_CONF_OPT += --enable-curl
else
ECORE_CONF_OPT += --disable-curl
endif

ifdef PTXCONF_ECORE_IMF
ECORE_CONF_OPT += --enable-ecore-imf
else
ECORE_CONF_OPT += --disable-ecore-imf
endif

ifdef PTXCONF_ECORE_CONFIG
ECORE_CONF_OPT += --enable-ecore-config
else
ECORE_CONF_OPT += --disable-ecore-config
endif

ifdef PTXCONF_ECORE_ABSTRACT_SOCKETS
ECORE_CONF_OPT += --enable-abstract-sockets
else
ECORE_CONF_OPT += --disable-abstract-sockets
endif

ifdef PTXCONF_ECORE_INPUT
ECORE_CONF_OPT += --enable-ecore-input
else
ECORE_CONF_OPT += --disable-ecore-input
endif

ifdef PTXCONF_ECORE_X
ECORE_CONF_OPT += --enable-ecore-x
else
ECORE_CONF_OPT += --disable-ecore-x
endif

ifdef PTXCONF_ECORE_IPC
ECORE_CONF_OPT += --enable-ecore-ipc
else
ECORE_CONF_OPT += --disable-ecore-ipc
endif

ifdef PTXCONF_ECORE_TSLIB
ECORE_CONF_OPT += --enable-tslib
else
ECORE_CONF_OPT += --disable-tslib
endif

#Ecore-Evas
ifdef PTXCONF_ECORE_EVAS
ECORE_CONF_OPT += --enable-ecore-evas

ifdef PTXCONF_ECORE_EVAS_INPUT
ECORE_CONF_OPT += --enable-ecore-input-evas
else
ECORE_CONF_OPT += --disable-ecore-input-evas
endif

ifdef PTXCONF_ECORE_EVAS_SOFTWARE_BUFFER
ECORE_CONF_OPT += --enable-ecore-evas-software-buffer
else
ECORE_CONF_OPT += --disable-ecore-evas-software-buffer
endif

ifdef PTXCONF_ECORE_EVAS_SOFTWARE_X11
ECORE_CONF_OPT += --enable-ecore-evas-software-x11
else
ECORE_CONF_OPT += --disable-ecore-evas-software-x11
endif

ifdef PTXCONF_ECORE_EVAS_XRENDER_X11
ECORE_CONF_OPT += --enable-ecore-evas-xrender-x11
else
ECORE_CONF_OPT += --disable-ecore-evas-xrender-x11
endif

ifdef PTXCONF_ECORE_EVAS_OPENGL_X11
ECORE_CONF_OPT += --enable-ecore-evas-opengl-x11
else
ECORE_CONF_OPT += --disable-ecore-evas-opengl-x11
endif

ifdef PTXCONF_ECORE_EVAS_SOFTWARE_16_X11
ECORE_CONF_OPT += --enable-ecore-evas-software-16-x11
else
ECORE_CONF_OPT += --disable-ecore-evas-software-16-x11
endif

ifdef PTXCONF_ECORE_EVAS_XRENDER_XCB
ECORE_CONF_OPT += --enable-ecore-evas-xrender-xcb
else
ECORE_CONF_OPT += --disable-ecore-evas-xrender-xcb
endif

ifdef PTXCONF_ECORE_EVAS_OPENGL_GLEW
ECORE_CONF_OPT += --enable-ecore-evas-opengl-glew
else
ECORE_CONF_OPT += --disable-ecore-evas-opengl-glew
endif

ifdef PTXCONF_ECORE_EVAS_SOFTWARE_SDL
ECORE_CONF_OPT += --enable-ecore-evas-software-sdl
else
ECORE_CONF_OPT += --disable-ecore-evas-software-sdl
endif

ifdef PTXCONF_ECORE_EVAS_OPENGL_SDL
ECORE_CONF_OPT += --enable-ecore-evas-opengl-sdl
else
ECORE_CONF_OPT += --disable-ecore-evas-opengl-sdl
endif

ifdef PTXCONF_ECORE_EVAS_DIRECTFB
ECORE_CONF_OPT += --enable-ecore-evas-directfb
else
ECORE_CONF_OPT += --disable-ecore-evas-directfb
endif

ifdef PTXCONF_ECORE_FB
ECORE_CONF_OPT += --enable-ecore-fb
else
ECORE_CONF_OPT += --disable-ecore-fb
endif

ifdef PTXCONF_ECORE_EVAS_FB
ECORE_CONF_OPT += --enable-ecore-evas-fb
else
ECORE_CONF_OPT += --disable-ecore-evas-fb
endif

ifdef PTXCONF_ECORE_IMF_EVAS
ECORE_CONF_OPT += --enable-ecore-imf-evas
else
ECORE_CONF_OPT += --disable-ecore-imf-evas
endif

else
ECORE_CONF_OPT += --disable-ecore-evas
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ecore.targetinstall:
	@$(call targetinfo)
	@$(call install_init, ecore)
	@$(call install_fixup, ecore, PRIORITY, optional)
	@$(call install_fixup, ecore, SECTION, base)
	@$(call install_fixup, ecore, AUTHOR, "Ryan Raasch <ryan.raasch@gmail.com>")
	@$(call install_fixup, ecore, DESCRIPTION, missing)

	@$(call install_lib, ecore, 0, 0, 0644, libecore-ver-svn-06)

ifdef PTXCONF_ECORE_IPC
	@$(call install_lib, ecore, 0, 0, 0644, libecore_ipc-ver-svn-06)
endif

ifdef PTXCONF_ECORE_CON
	@$(call install_lib, ecore, 0, 0, 0644, libecore_con-ver-svn-06)
endif

ifdef PTXCONF_ECORE_FB
	@$(call install_lib, ecore, 0, 0, 0644, libecore_fb-ver-svn-06)
endif

ifdef PTXCONF_ECORE_FILE
	@$(call install_lib, ecore, 0, 0, 0644, libecore_file-ver-svn-06)
endif

ifdef PTXCONF_ECORE_INPUT
	@$(call install_lib, ecore, 0, 0, 0644, libecore_input-ver-svn-06)
endif

ifdef PTXCONF_ECORE_XINPUT
	@$(call install_lib, ecore, 0, 0, 0644, libecore_input-ver-svn-06)
endif

ifdef PTXCONF_ECORE_EVAS
	@$(call install_lib, ecore, 0, 0, 0644, libecore_evas-ver-svn-06)
endif

ifdef PTXCONF_ECORE_EVAS_INPUT
	@$(call install_lib, ecore, 0, 0, 0644, libecore_input_evas-ver-svn-06)
endif
	@$(call install_finish, ecore)
	@$(call touch)

# vim: syntax=make
