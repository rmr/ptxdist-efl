# -*-makefile-*-
#  
# $Id: pii_nge.make,v 1.8 2004/08/24 13:08:27 rsc Exp $
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = pii_nge

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pii_nge_targetinstall: $(STATEDIR)/pii_nge.targetinstall

$(STATEDIR)/pii_nge.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)

	# remove CVS stuff
	find $(ROOTDIR) -name "CVS" | xargs rm -fr 
	rm -f $(ROOTDIR)/JUST_FOR_CVS

	#  generate version stamps
	perl -i -p -e "s,\@VERSION@,$(VERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PATCHLEVEL@,$(PATCHLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@SUBLEVEL@,$(SUBLEVEL),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PROJECT@,$(PROJECT),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@EXTRAVERSION@,$(EXTRAVERSION),g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@DATE@,$(shell date -Iseconds),g" $(ROOTDIR)/etc/init.d/banner

	# other config data
	rm -f $(ROOTDIR)/etc/hostname
	perl -i -p -e "s,\@CONSOLE@,tts/0,g" $(ROOTDIR)/etc/inittab
	perl -i -p -e "s,\@SPEED@,115200,g" $(ROOTDIR)/etc/inittab
	perl -i -p -e "s,\@VENDOR@,PII ,g" $(ROOTDIR)/etc/init.d/banner
	perl -i -p -e "s,\@PS1@,\'\\\u@\\\h:\\\w> \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@PS2@,\'> \',g" $(ROOTDIR)/etc/profile
	perl -i -p -e "s,\@PS4@,\'+ \',g" $(ROOTDIR)/etc/profile

	# create some mountpoints	
	$(call copy_root, 0, 0, 0755, /var/run)
	$(call copy_root, 0, 0, 0755, /var/log)
	$(call copy_root, 0, 0, 0755, /var/lock)
	
	# create /etc/rc.d links
	$(call copy_root, 0, 0, 0755, /etc/rc.d)
	$(call link_root, ../init.d/banner,     /etc/rc.d/S00_banner)
	$(call link_root, ../init.d/networking, /etc/rc.d/S01_networking)
	$(call link_root, ../init.d/utelnetd,   /etc/rc.d/S02_utelnetd)

	touch $@

# vim: syntax=make
