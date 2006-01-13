# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KONQ-E) += konq-e

#
# Paths and names
#
KONQ-E_VERSION		= snapshot-20030705
KONQ-E			= konqueror-embedded-$(KONQ-E_VERSION)
KONQ-E_SUFFIX		= tar.gz
KONQ-E_URL		= http://devel-home.kde.org/~hausmann/snapshots/$(KONQ-E).$(KONQ-E_SUFFIX)
KONQ-E_SOURCE		= $(SRCDIR)/$(KONQ-E).$(KONQ-E_SUFFIX)
KONQ-E_DIR		= $(BUILDDIR)/$(KONQ-E)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

konq-e_get: $(STATEDIR)/konq-e.get

$(STATEDIR)/konq-e.get: $(konq-e_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KONQ-E_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KONQ-E_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

konq-e_extract: $(STATEDIR)/konq-e.extract

$(STATEDIR)/konq-e.extract: $(konq-e_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KONQ-E_DIR))
	@$(call extract, $(KONQ-E_SOURCE))
	@$(call patchin, $(KONQ-E))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

konq-e_prepare: $(STATEDIR)/konq-e.prepare

KONQ-E_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
KONQ-E_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
KONQ-E_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/konq-e.prepare: $(konq-e_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KONQ-E_BUILDDIR))
	cd $(KONQ-E_DIR) && \
		$(KONQ-E_PATH) $(KONQ-E_ENV) \
		./configure $(KONQ-E_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

konq-e_compile: $(STATEDIR)/konq-e.compile

$(STATEDIR)/konq-e.compile: $(konq-e_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(KONQ-E_DIR) && $(KONQ-E_PATH) $(KONQ-E_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

konq-e_install: $(STATEDIR)/konq-e.install

$(STATEDIR)/konq-e.install: $(konq-e_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME: RSC: shouldn't this be target-install? 
	@$(call install, KONQ-E)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

konq-e_targetinstall: $(STATEDIR)/konq-e.targetinstall

$(STATEDIR)/konq-e.targetinstall: $(konq-e_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

konq-e_clean:
	rm -rf $(STATEDIR)/konq-e.*
	rm -rf $(KONQ-E_DIR)

# vim: syntax=make
