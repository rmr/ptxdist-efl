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
PACKAGES-$(PTXCONF_ENLIGHTENMENT) += enlightenment

#
# Paths and names
#
ENLIGHTENMENT_VERSION	:= 0.16.999.49898
ENLIGHTENMENT		:= enlightenment-$(ENLIGHTENMENT_VERSION)
ENLIGHTENMENT_SUFFIX	:= tar.bz2
ENLIGHTENMENT_URL	:= http://download.enlightenment.org/snapshots/2010-06-27/$(ENLIGHTENMENT).$(ENLIGHTENMENT_SUFFIX)
ENLIGHTENMENT_SOURCE	:= $(SRCDIR)/$(ENLIGHTENMENT).$(ENLIGHTENMENT_SUFFIX)
ENLIGHTENMENT_DIR	:= $(BUILDDIR)/$(ENLIGHTENMENT)
ENLIGHTENMENT_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ENLIGHTENMENT_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
ENLIGHTENMENT_CONF_TOOL	:= autoconf
ENLIGHTENMENT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doc \
	--with-edje-cc=$(PTXCONF_SYSROOT_HOST)/bin/edje_cc \
	--with-eet-eet=$(PTXCONF_SYSROOT_HOST)/bin/eet

ifdef PTXCONF_ENLIGHTENMENT_FILES
ENLIGHTENMENT_CONF_OPT += --enable-files
else
ENLIGHTENMENT_CONF_OPT += --disable-files
endif

ifdef PTXCONF_ENLIGHTENMENT_DEVICE_HAL
ENLIGHTENMENT_CONF_OPT += --enable-device-hal
else
ENLIGHTENMENT_CONF_OPT += --disable-device-hal
endif

ifdef PTXCONF_ENLIGHTENMENT_DEVICE_UDEV
ENLIGHTENMENT_CONF_OPT += --enable-device-udev
else
ENLIGHTENMENT_CONF_OPT += --disable-device-udev
endif

ifdef PTXCONF_ENLIGHTENMENT_EXCHANGE
ENLIGHTENMENT_CONF_OPT += --enable-exchange
else
ENLIGHTENMENT_CONF_OPT += --disable-exchange
endif

ifdef PTXCONF_ENLIGHTENMENT_IBAR
ENLIGHTENMENT_CONF_OPT += --enable-ibar
else
ENLIGHTENMENT_CONF_OPT += --disable-ibar
endif

ifdef PTXCONF_ENLIGHTENMENT_DROPSHADOW
ENLIGHTENMENT_CONF_OPT += --enable-dropshadow
else
ENLIGHTENMENT_CONF_OPT += --disable-dropshadow
endif

ifdef PTXCONF_ENLIGHTENMENT_CLOCK
ENLIGHTENMENT_CONF_OPT += --enable-clock
else
ENLIGHTENMENT_CONF_OPT += --disable-clock
endif

ifdef PTXCONF_ENLIGHTENMENT_PAGER
ENLIGHTENMENT_CONF_OPT += --enable-pager
else
ENLIGHTENMENT_CONF_OPT += --disable-pager
endif

ifdef PTXCONF_ENLIGHTENMENT_BATTERY
ENLIGHTENMENT_CONF_OPT += --enable-battery
else
ENLIGHTENMENT_CONF_OPT += --disable-battery
endif

ifdef PTXCONF_ENLIGHTENMENT_TEMPERATURE
ENLIGHTENMENT_CONF_OPT += --enable-temperature
else
ENLIGHTENMENT_CONF_OPT += --disable-temperature
endif

ifdef PTXCONF_ENLIGHTENMENT_CPUFREQ
ENLIGHTENMENT_CONF_OPT += --enable-cpufreq
else
ENLIGHTENMENT_CONF_OPT += --disable-cpufreq
endif

ifdef PTXCONF_ENLIGHTENMENT_IBOX
ENLIGHTENMENT_CONF_OPT += --enable-ibox
else
ENLIGHTENMENT_CONF_OPT += --disable-ibox
endif

ifdef PTXCONF_ENLIGHTENMENT_START
ENLIGHTENMENT_CONF_OPT += --enable-start
else
ENLIGHTENMENT_CONF_OPT += --disable-start
endif

ifdef PTXCONF_ENLIGHTENMENT_WINLIST
ENLIGHTENMENT_CONF_OPT += --enable-winlist
else
ENLIGHTENMENT_CONF_OPT += --disable-winlist
endif

ifdef PTXCONF_ENLIGHTENMENT_FILEMAN
ENLIGHTENMENT_CONF_OPT += --enable-fileman
else
ENLIGHTENMENT_CONF_OPT += --disable-fileman
endif

ifdef PTXCONF_ENLIGHTENMENT_FILEMAN_OPINFO
ENLIGHTENMENT_CONF_OPT += --enable-fileman-opinfo
else
ENLIGHTENMENT_CONF_OPT += --disable-fileman-opinfo
endif

ifdef PTXCONF_ENLIGHTENMENT_WIZARD
ENLIGHTENMENT_CONF_OPT += --enable-wizard
else
ENLIGHTENMENT_CONF_OPT += --disable-wizard
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF
ENLIGHTENMENT_CONF_OPT += --enable-conf
else
ENLIGHTENMENT_CONF_OPT += --disable-conf
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WALLPAPER
ENLIGHTENMENT_CONF_OPT += --enable-conf-wallpaper
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-wallpaper
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WALLPAPER2
ENLIGHTENMENT_CONF_OPT += --enable-conf-wallpaper2
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-wallpaper2
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_THEME
ENLIGHTENMENT_CONF_OPT += --enable-conf-theme
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-theme
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_COLORS
ENLIGHTENMENT_CONF_OPT += --enable-conf-colors
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-colors
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_FONTS
ENLIGHTENMENT_CONF_OPT += --enable-conf-fonts
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-fonts
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_BORDERS
ENLIGHTENMENT_CONF_OPT += --enable-conf-borders
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-borders
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_ICON_THEME
ENLIGHTENMENT_CONF_OPT += --enable-conf-icon-theme
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-icon-theme
endif

ifdef PTXCONF_ENLIGHTENMENT_MOUSE_CURSOR
ENLIGHTENMENT_CONF_OPT += --enable-conf-mouse-cursor
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-mouse-cursor
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_TRANSITIONS
ENLIGHTENMENT_CONF_OPT += --enable-conf-transitions
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-transitions
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_STARTUP
ENLIGHTENMENT_CONF_OPT += --enable-conf-startup
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-startup
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_INTL
ENLIGHTENMENT_CONF_OPT += --enable-conf-intl
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-intl
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_IMC
ENLIGHTENMENT_CONF_OPT += --enable-conf-imc
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-imc
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_PROFILES
ENLIGHTENMENT_CONF_OPT += --enable-conf-profiles
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-profiles
endif

ifdef PTXCONF_ENLIGHTENMENT_MSGBUS
ENLIGHTENMENT_CONF_OPT += --enable-msgbus
else
ENLIGHTENMENT_CONF_OPT += --disable-msgbus
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_ENGINE
ENLIGHTENMENT_CONF_OPT += --enable-conf-engine
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-engine
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_APPLICATIONS
ENLIGHTENMENT_CONF_OPT += --enable-conf-applications
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-applications
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_DESTS
ENLIGHTENMENT_CONF_OPT += --enable-conf-desks
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-desks
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_DESK
ENLIGHTENMENT_CONF_OPT += --enable-conf-desk
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-desk
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_DISPLAY
ENLIGHTENMENT_CONF_OPT += --enable-conf-display
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-display
endif

ifdef PTXCONF_ENLIGHTENMENT_DESKLOCK
ENLIGHTENMENT_CONF_OPT += --enable-conf-desklock
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-desklock
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_SCREENSAVER
ENLIGHTENMENT_CONF_OPT += --enable-conf-screensaver
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-screensaver
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_DPMS
ENLIGHTENMENT_CONF_OPT += --enable-conf-dpms
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-dpms
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_SHELVES
ENLIGHTENMENT_CONF_OPT += --enable-conf-shelves
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-shelves
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_KEYBINDINGS
ENLIGHTENMENT_CONF_OPT += --enable-conf-keybindings
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-keybindings
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_MOUSEBINDINGS
ENLIGHTENMENT_CONF_OPT += --enable-conf-mousebindings
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-mousebindings
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_EDJEBINDINGS
ENLIGHTENMENT_CONF_OPT += --enable-conf-edgebindings
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-edgebindings
endif


ifdef PTXCONF_ENLIGHTENMENT_CONF_ACPIBINDINGS
ENLIGHTENMENT_CONF_OPT += --disable-conf-acpibindings
else
ENLIGHTENMENT_CONF_OPT += --enable-conf-acpibindings
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_MOUSE
ENLIGHTENMENT_CONF_OPT += --enable-conf-mouse
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-mouse
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WINDOW_DISPLAY
ENLIGHTENMENT_CONF_OPT += --enable-conf-window-display
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-window-display
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WINDOW_FOCUS
ENLIGHTENMENT_CONF_OPT += --enable-conf-window-focus
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-window-focus
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WINDOW_REMEMBERS
ENLIGHTENMENT_CONF_OPT += --enable-conf-window-remembers
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-window-remembers
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WINDOW_MANUPULATION
ENLIGHTENMENT_CONF_OPT += --enable-conf-window-manipulation
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-window-manipulation
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_MENUS
ENLIGHTENMENT_CONF_OPT += --enable-conf-menus
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-menus
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_CLIENTLIST
ENLIGHTENMENT_CONF_OPT += --enable-conf-clientlist
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-clientlist
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_DIALOGS
ENLIGHTENMENT_CONF_OPT += --enable-conf-dialogs
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-dialogs
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_PERFORMANCE
ENLIGHTENMENT_CONF_OPT += --enable-conf-performance
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-performance
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_WINLIST
ENLIGHTENMENT_CONF_OPT += --enable-conf-winlist
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-winlist
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_PATHS
ENLIGHTENMENT_CONF_OPT += --enable-conf-paths
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-paths
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_MIME
ENLIGHTENMENT_CONF_OPT += --enable-conf-mime
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-mime
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_INTERACTION
ENLIGHTENMENT_CONF_OPT += --enable-conf-interaction
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-interaction
endif

ifdef PTXCONF_ENLIGHTENMENT_CONF_SCALE
ENLIGHTENMENT_CONF_OPT += --enable-conf-scale
else
ENLIGHTENMENT_CONF_OPT += --disable-conf-scale
endif

ifdef PTXCONF_ENLIGHTENMENT_GADMAN
ENLIGHTENMENT_CONF_OPT += --enable-gadman
else
ENLIGHTENMENT_CONF_OPT += --disable-gadman
endif

ifdef PTXCONF_ENLIGHTENMENT_MIXER
ENLIGHTENMENT_CONF_OPT += --enable-mixer
else
ENLIGHTENMENT_CONF_OPT += --disable-mixer
endif

ifdef PTXCONF_ENLIGHTENMENT_CONNMAN
ENLIGHTENMENT_CONF_OPT += --enable-connman
else
ENLIGHTENMENT_CONF_OPT += --disable-connman
endif

ifdef PTXCONF_ENLIGHTENMENT_BLUEZ
ENLIGHTENMENT_CONF_OPT += --enable-bluez
else
ENLIGHTENMENT_CONF_OPT += --disable-bluez
endif

ifdef PTXCONF_ENLIGHTENMENT_OFONO
ENLIGHTENMENT_CONF_OPT += --enable-ofono
else
ENLIGHTENMENT_CONF_OPT += --disable-ofono
endif

ifdef PTXCONF_ENLIGHTENMENT_ILLUME
ENLIGHTENMENT_CONF_OPT += --enable-illume
else
ENLIGHTENMENT_CONF_OPT += --disable-illume
endif

ifdef PTXCONF_ENLIGHTENMENT_ILLUME2
ENLIGHTENMENT_CONF_OPT += --enable-illume2
else
ENLIGHTENMENT_CONF_OPT += --disable-illume2
endif

ifdef PTXCONF_ENLIGHTENMENT_SYSCON
ENLIGHTENMENT_CONF_OPT += --enable-syscon
else
ENLIGHTENMENT_CONF_OPT += --disable-syscon
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING
ENLIGHTENMENT_CONF_OPT += --enable-everything
else
ENLIGHTENMENT_CONF_OPT += --disable-everything
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING_FILES
ENLIGHTENMENT_CONF_OPT += --enable-everything-files
else
ENLIGHTENMENT_CONF_OPT += --disable-everything-files
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING_APPS
ENLIGHTENMENT_CONF_OPT += --enable-everything-apps
else
ENLIGHTENMENT_CONF_OPT += --disable-everything-apps
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING_CALC
ENLIGHTENMENT_CONF_OPT += --enable-everything-calc
else
ENLIGHTENMENT_CONF_OPT += --disable-everything-apps
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING_ASPELL
ENLIGHTENMENT_CONF_OPT += --enable-everything-aspell
else
ENLIGHTENMENT_CONF_OPT += --disable-everything-aspell
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING_SETTINGS
ENLIGHTENMENT_CONF_OPT += --enable-everything-settings
else
ENLIGHTENMENT_CONF_OPT += --disable-everything-settings
endif

ifdef PTXCONF_ENLIGHTENMENT_EVERYTHING_WINDOWS
ENLIGHTENMENT_CONF_OPT += --enable-everything-windows
else
ENLIGHTENMENT_CONF_OPT += --disable-everything-windows
endif

ifdef PTXCONF_ENLIGHTENMENT_SYSTRAY
ENLIGHTENMENT_CONF_OPT += --enable-systray
else
ENLIGHTENMENT_CONF_OPT += --disable-systray
endif

ifdef PTXCONF_ENLIGHTENMENT_COMP
ENLIGHTENMENT_CONF_OPT += --enable-comp
else
ENLIGHTENMENT_CONF_OPT += --disable-comp
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/enlightenment.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  enlightenment)
	@$(call install_fixup, enlightenment,PRIORITY,optional)
	@$(call install_fixup, enlightenment,SECTION,base)
	@$(call install_fixup, enlightenment,AUTHOR,"<Ryan Raasch ryan.raasch@gmail.com>")
	@$(call install_fixup, enlightenment,DESCRIPTION,missing)

	@cd $(ENLIGHTENMENT_PKGDIR)/usr/lib/enlightenment/modules && \
	for file in `find . -name '*.so'`; do \
		$(call install_copy, enlightenment, 0, 0, 0644, -, /usr/lib/enlightenment/modules/$$file); \
	done;

	@$(call install_finish, enlightenment)

	@$(call touch)

# vim: syntax=make
