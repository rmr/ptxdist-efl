# -*-makefile-*-

#
# ncurses-config handling
#
# add $(CROSS_ENV_AC_NCURSES) to your _ENV if ncurses should be detected
# use $(CROSS_ENV_AC_NO_NCURSES) if you ncurses should not be detected
#

# defaults
CROSS_ENV_AC_NCURSESW5_CONFIG	:= no
CROSS_ENV_AC_NCURSES5_CONFIG	:= no

# modify if ncurses is enabled
ifdef PTXCONF_NCURSES
ifdef PTXCONF_NCURSES_WIDE_CHAR
CROSS_ENV_AC_NCURSESW5_CONFIG	:= yes
else
CROSS_ENV_AC_NCURSES5_CONFIG	:= yes
endif
endif

CROSS_ENV_AC_NCURSES := \
	ac_cv_prog_ncurses5_config=$(CROSS_ENV_AC_NCURSES5_CONFIG) \
	ac_cv_prog_ncursesw5_config=$(CROSS_ENV_AC_NCURSESW5_CONFIG)

CROSS_ENV_AC_NO_NCURSES := \
	ac_cv_prog_ncurses5_config=no
	ac_cv_prog_ncursesw5_config=no

# vim: syntax=make