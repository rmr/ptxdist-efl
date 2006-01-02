# -*-makefile-*-
# $Id: template 3502 2005-12-11 12:46:17Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COMMONCPP2) += commoncpp2

#
# Paths and names
#
COMMONCPP2_VERSION	= 1.3.22
COMMONCPP2		= commoncpp2-$(COMMONCPP2_VERSION)
COMMONCPP2_SUFFIX	= tar.gz
COMMONCPP2_URL		= $(PTXCONF_SETUP_SFMIRROR)/gnutelephony/$(COMMONCPP2).$(COMMONCPP2_SUFFIX)
COMMONCPP2_SOURCE	= $(SRCDIR)/$(COMMONCPP2).$(COMMONCPP2_SUFFIX)
COMMONCPP2_DIR		= $(BUILDDIR)/$(COMMONCPP2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

commoncpp2_get: $(STATEDIR)/commoncpp2.get

commoncpp2_get_deps = $(COMMONCPP2_SOURCE)

$(STATEDIR)/commoncpp2.get: $(commoncpp2_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(COMMONCPP2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(COMMONCPP2_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

commoncpp2_extract: $(STATEDIR)/commoncpp2.extract

commoncpp2_extract_deps = $(STATEDIR)/commoncpp2.get

$(STATEDIR)/commoncpp2.extract: $(commoncpp2_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(COMMONCPP2_DIR))
	@$(call extract, $(COMMONCPP2_SOURCE))
	@$(call patchin, $(COMMONCPP2))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

commoncpp2_prepare: $(STATEDIR)/commoncpp2.prepare

#
# dependencies
#
commoncpp2_prepare_deps = \
	$(STATEDIR)/commoncpp2.extract \
	$(STATEDIR)/virtual-xchain.install

COMMONCPP2_PATH	=  PATH=$(CROSS_PATH)
COMMONCPP2_ENV 	=  $(CROSS_ENV)
COMMONCPP2_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
COMMONCPP2_AUTOCONF =  $(CROSS_AUTOCONF_USR)
COMMONCPP2_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/commoncpp2.prepare: $(commoncpp2_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(COMMONCPP2_DIR)/config.cache)
	cd $(COMMONCPP2_DIR) && \
		$(COMMONCPP2_PATH) $(COMMONCPP2_ENV) \
		./configure $(COMMONCPP2_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

commoncpp2_compile: $(STATEDIR)/commoncpp2.compile

commoncpp2_compile_deps = $(STATEDIR)/commoncpp2.prepare

$(STATEDIR)/commoncpp2.compile: $(commoncpp2_compile_deps)
	@$(call targetinfo, $@)
	cd $(COMMONCPP2_DIR) && $(COMMONCPP2_ENV) $(COMMONCPP2_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

commoncpp2_install: $(STATEDIR)/commoncpp2.install

$(STATEDIR)/commoncpp2.install: $(STATEDIR)/commoncpp2.compile
	@$(call targetinfo, $@)
	@$(call install, COMMONCPP2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

commoncpp2_targetinstall: $(STATEDIR)/commoncpp2.targetinstall

commoncpp2_targetinstall_deps = $(STATEDIR)/commoncpp2.compile

$(STATEDIR)/commoncpp2.targetinstall: $(commoncpp2_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,commoncpp2)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(COMMONCPP2_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(COMMONCPP2_DIR)/src/.libs/libccgnu2-1.3.so.1.0.18, \
		/usr/lib/libccgnu2-1.3.so.1.0.18)

	@$(call install_link, libccgnu2-1.3.so.1.0.18, /usr/lib//usr/lib/libccgnu2-1.3.so.1)
	@$(call install_link, libccgnu2-1.3.so.1.0.18, /usr/lib//usr/lib/libccgnu2-1.3.so)

	@$(call install_copy, 0, 0, 0644, \
		$(COMMONCPP2_DIR)/src/.libs/libccext2-1.3.so.1.0.18 \
		libccext2-1.3.so.1.0.18)

	@$(call install_link, libccext2-1.3.so.1.0.18, /usr/lib//usr/lib/libccext2-1.3.so.1)
	@$(call install_link, libccext2-1.3.so.1.0.18, /usr/lib//usr/lib/libccext2-1.3.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

commoncpp2_clean:
	rm -rf $(STATEDIR)/commoncpp2.*
	rm -rf $(IMAGEDIR)/commoncpp2_*
	rm -rf $(COMMONCPP2_DIR)

# vim: syntax=make
