# -*-makefile-*-

#
# install_copy
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source (for files); directory (for directories)
# $6: a) destination (for files); empty (for directories). Prefixed with $(ROOTDIR),
#     so it needs to have a leading /
#     b) empty -> src file is taken from PKG_PKGDIR, so you only have to specify
#        a path like /usr/bin/blub there
# $7: strip (for files; y|n); default is to strip
#
#	PKG_PKGDIR="$(PKGDIR)/$($(call uppercase, $(1)))";					\
#	if [ -z "$(6)" ]; then									\
#		SRC=$${PKG_PKGDIR}/$$SRC;							\
#	fi; 											\
#
install_copy = 											\
	PACKET="$(strip $(1))";									\
	OWN="$(strip $(2))";									\
	GRP="$(strip $(3))";									\
	PER="$(strip $(4))";									\
	SRC="$(strip $(5))";									\
	DST="$(strip $(6))";									\
	STRIP="$(strip $(7))";									\
												\
	PER_NFS=$$(printf "0%o" $$(( 0$${PER} & ~06000 )) );					\
												\
	if [ -z "$(6)" ]; then									\
		echo "install_copy:";								\
		echo "  dir=$$SRC";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER";							\
		$(INSTALL) -d "$(PKGDIR)/$$PACKET.tmp/ipkg/$$SRC";				\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS -d "$(ROOTDIR)/$$SRC";					\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS -d "$(ROOTDIR_DEBUG)/$$SRC";				\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		mkdir -p "$(PKGDIR)/$$PACKET.tmp";						\
		echo "f:$$SRC:$$OWN:$$GRP:$$PER" >> "$(STATEDIR)/$$PACKET.perms";		\
	else											\
		if [ -e "$${SRC}$(PTXDIST_PLATFORMSUFFIX)" ]; then				\
			SRC="$${SRC}$(PTXDIST_PLATFORMSUFFIX)";					\
		fi;										\
		echo "install_copy:";								\
		echo "  src=$$SRC";								\
		echo "  dst=$$DST";								\
		echo "  owner=$$OWN";								\
		echo "  group=$$GRP";								\
		echo "  permissions=$$PER"; 							\
		rm -fr "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST"; 					\
		$(INSTALL) -D "$$SRC" "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST";			\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS -D "$$SRC" "$(ROOTDIR)$$DST";				\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		$(INSTALL) -m $$PER_NFS -D "$$SRC" "$(ROOTDIR_DEBUG)$$DST";			\
		if [ $$? -ne 0 ]; then								\
			echo "Error: install_copy failed!";					\
			exit 1;									\
		fi;										\
		case "$$STRIP" in								\
		(0 | n | no)									\
			;;									\
		(*)											\
			file "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST" | grep -q "not stripped";		\
				case "$$?" in								\
				(0)									\
				$(CROSS_STRIP) -R .note -R .comment "$(PKGDIR)/$$PACKET.tmp/ipkg/$$DST";\
				if [ $$? -ne 0 ]; then							\
					echo "Error: install_copy failed!";				\
					exit 1;								\
				fi;									\
				$(CROSS_STRIP) -R .note -R .comment "$(ROOTDIR)$$DST";			\
				if [ $$? -ne 0 ]; then							\
					echo "Error: install_copy failed!";				\
					exit 1;								\
				fi;									\
				;;									\
				(1)									\
				echo "no unstripped binary - skipping";					\
				;;									\
				esac;									\
			;;										\
		esac;											\
		mkdir -p "$(PKGDIR)/$$PACKET.tmp";							\
		echo "f:$$DST:$$OWN:$$GRP:$$PER" >> "$(STATEDIR)/$$PACKET.perms";			\
	fi

#
# install_alternative
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# This macro first looks in $(PTXDIST_WORKSPACE)/projectroot for the file to copy and then
# in $(PTXDIST_TOPDIR)/generic and installs the file under $(ROOTDIR)
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source file
#
install_alternative =									\
	PACKET=$(strip $(1));								\
	OWN=$(strip $(2));								\
	GRP=$(strip $(3));								\
	PER=$(strip $(4));								\
	FILE=$(strip $(5));								\
	if [ -f $(PTXDIST_WORKSPACE)/projectroot$$FILE ]; then				\
		SRC=$(PTXDIST_WORKSPACE)/projectroot$$FILE;				\
	else										\
		SRC=$(PTXDIST_TOPDIR)/generic$$FILE;					\
	fi;										\
	echo "install_alternative:";							\
	echo "  installing $$FILE from $$SRC";						\
	echo "  owner=$$OWN";								\
	echo "  group=$$GRP";								\
	echo "  permissions=$$PER"; 							\
	rm -fr $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE; 					\
	$(INSTALL) -D $$SRC $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE;				\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_alternative failed!";				\
		exit 1;									\
	fi;										\
	$(INSTALL) -m $$PER -D $$SRC $(ROOTDIR)$$FILE;					\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_alternative failed!";				\
		exit 1;									\
	fi;										\
	$(INSTALL) -m $$PER -D $$SRC $(ROOTDIR_DEBUG)$$FILE;				\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_alternative failed!";				\
		exit 1;									\
	fi;										\
	mkdir -p $(PKGDIR)/$$PACKET.tmp;						\
	echo "f:$$FILE:$$OWN:$$GRP:$$PER" >> $(STATEDIR)/$$PACKET.perms;

#
# install_replace
#
# Replace placeholder with value in a previously
# installed file
#
# $1: label of the packet
# $2: filename
# $3: placeholder
# $4: value
#
install_replace = \
	PACKET=$(strip $(1));									\
	FILE=$(strip $(2));									\
	PLACEHOLDER=$(strip $(3));								\
	VALUE=$(strip $(4));									\
	if [ ! -f "$(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE" ]; then 					\
		echo;										\
		echo "install_replace: error: file not found: $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE";\
		echo;										\
		exit 1;										\
	fi;											\
	if [ ! -f "$(ROOTDIR)/$$FILE" ]; then 							\
		echo										\
		echo "install_replace: error: file not found: $(ROOTDIR)/$$FILE";		\
		echo;										\
		exit 1;										\
	fi;											\
	if [ ! -f "$(ROOTDIR_DEBUG)/$$FILE" ]; then 						\
		echo										\
		echo "install_replace: error: file not found: $(ROOTDIR_DEBUG)/$$FILE";		\
		echo;										\
		exit 1;										\
	fi;											\
	sed -i -e "s,$$PLACEHOLDER,$$VALUE,g" $(PKGDIR)/$$PACKET.tmp/ipkg/$$FILE;		\
	sed -i -e "s,$$PLACEHOLDER,$$VALUE,g" $(ROOTDIR)/$$FILE;				\
	sed -i -e "s,$$PLACEHOLDER,$$VALUE,g" $(ROOTDIR_DEBUG)/$$FILE;

#
# install_copy_toolchain_lib
#
# $1: packet label
# $2: source
# $3: destination
# $4: strip (y|n)	default is to strip
#
install_copy_toolchain_lib =									\
	PACKET=$(strip $(1));									\
	LIB="$(strip $2)";									\
	DST="$(strip $3)";									\
	STRIP="$(strip $4)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${PACKET}" -l "$${LIB}" $${DST} -s "$${STRIP}"

#
# install_copy_toolchain_dl
#
# $1: packet label
# $2: destination
# $3: strip (y|n)	default is to strip
#
install_copy_toolchain_dl =									\
	PACKET=$(strip $(1));									\
	DST="$(strip $2)";									\
	STRIP="$(strip $3)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${PACKET}" -l LINKER $${DST} -s "$${STRIP}"

#
# install_copy_toolchain_other
#
# $1: packet label
# $2: source
# $3: destination
# $4: strip (y|n)	default is to strip
#
install_copy_toolchain_usr =									\
	PACKET=$(strip $(1));									\
	LIB="$(strip $2)";									\
	DST="$(strip $3)";									\
	STRIP="$(strip $4)";									\
	test "$${DST}" != "" && DST="-d $${DST}";						\
	${CROSS_ENV_CC} $(CROSS_ENV_STRIP) PKGDIR="$(PKGDIR)"					\
		$(SCRIPTSDIR)/install_copy_toolchain.sh -p "$${PACKET}" -u "$${LIB}" $${DST} -s "$${STRIP}"

#
# install_link
#
# Installs a soft link in root directory in an ipkg packet.
#
# $1: packet label
# $2: source
# $3: destination
#
install_link =									\
	PACKET=$(strip $(1));							\
	SRC=$(strip $(2));							\
	DST=$(strip $(3));							\
	rm -fr $(ROOTDIR)$$DST;							\
	rm -fr $(ROOTDIR_DEBUG)$$DST;						\
	echo "install_link: src=$$SRC dst=$$DST "; 				\
	mkdir -p `dirname $(ROOTDIR)$$DST`;					\
	mkdir -p `dirname $(ROOTDIR_DEBUG)$$DST`;				\
	ln -sf $$SRC $(ROOTDIR)$$DST; 						\
	ln -sf $$SRC $(ROOTDIR_DEBUG)$$DST; 					\
	mkdir -p `dirname $(PKGDIR)/$$PACKET.tmp/ipkg$$DST`;			\
	ln -sf $$SRC $(PKGDIR)/$$PACKET.tmp/ipkg/$$DST

#
# install_node
#
# Installs a device node in root directory in an ipkg packet.
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: type
# $6: major
# $7: minor
# $8: device node name
#
install_node =				\
	PACKET=$(strip $(1));		\
	OWN=$(strip $(2));		\
	GRP=$(strip $(3));		\
	PER=$(strip $(4));		\
	TYP=$(strip $(5));		\
	MAJ=$(strip $(6));		\
	MIN=$(strip $(7));		\
	DEV=$(strip $(8));		\
	echo "install_node:";		\
	echo "  owner=$$OWN";		\
	echo "  group=$$GRP";		\
	echo "  permissions=$$PER";	\
	echo "  type=$$TYP";		\
	echo "  major=$$MAJ";		\
	echo "  minor=$$MIN";		\
	echo "  name=$$DEV";		\
	mkdir -p $(PKGDIR)/$$PACKET.tmp;\
	echo "n:$$DEV:$$OWN:$$GRP:$$PER:$$TYP:$$MAJ:$$MIN" >> $(STATEDIR)/$$PACKET.perms

#
# install_fixup
#
# Replaces @...@ sequences in rules/*.ipkg files
#
# $1: packet label
# $2: sequence to be replaced
# $3: replacement
#
# Note: Package must not contain '_' as ipkg needs it as a seperator
install_fixup = 									\
	PACKET=$(strip $(1));								\
	REPLACE_FROM=$(strip $(2));							\
	REPLACE_TO=$(strip $(3));							\
											\
	case "$${REPLACE_FROM}" in							\
		(AUTHOR)								\
			REPLACE_TO="`echo $${REPLACE_TO} | sed -e 's/[^\\]@/\\\@/g'`";	\
			;;								\
		(PACKAGE)								\
			REPLACE_TO="`echo $${REPLACE_TO} | sed -e 's/_/-/g'`";		\
			;;								\
		(VERSION)								\
			REPLACE_TO="$${REPLACE_TO}$(PTXCONF_PROJECT_BUILD)";		\
			;;								\
	esac;										\
											\
	echo -n "install_fixup:  @$$REPLACE_FROM@ -> $$REPLACE_TO ... "; 		\
	sed -i -e "s,@$$REPLACE_FROM@,$$REPLACE_TO,g" "$(PKGDIR)/$$PACKET.tmp/ipkg/CONTROL/control"; \
	echo "done.";

#
# install_init
#
# Deletes $(PKGDIR)/$$PACKET.tmp/ipkg and prepares for new ipkg package creation
#
# $1: packet label
#
install_init =										\
	PACKET=$(strip $(1));								\
	echo "install_init: preparing for image creation...";				\
	rm -fr $(PKGDIR)/$$PACKET.tmp/*;						\
	rm -f $(STATEDIR)/$$PACKET.perms;						\
	mkdir -p $(PKGDIR)/$$PACKET.tmp/ipkg/CONTROL; 					\
	cp -f $(RULESDIR)/default.ipkg $(PKGDIR)/$$PACKET.tmp/ipkg/CONTROL/control;	\
	REPLACE_FROM="ARCH";								\
	REPLACE_TO=$(PTXDIST_IPKG_ARCH_STRING);						\
	echo -n "install_init:   @$$REPLACE_FROM@ -> $$REPLACE_TO ... ";	 	\
	sed -i -e "s,@$$REPLACE_FROM@,$$REPLACE_TO,g" $(PKGDIR)/$$PACKET.tmp/ipkg/CONTROL/control; \
	echo "done"; \
	for script in preinst postinst prerm postrm; do \
		echo -n "install_init:   $$script "; \
		if [ -f "${PTXDIST_WORKSPACE}/rules/$$PACKET.$$script" ]; then \
			$(INSTALL) -m 0755 \
				-D ${PTXDIST_WORKSPACE}/rules/$$PACKET.$$script \
				$(PKGDIR)/$$PACKET.tmp/ipkg/CONTROL/$$script; \
			echo "found in project, packaging"; \
		else if [ -f "${PTXDIST_TOPDIR}/rules/$$PACKET.$$script" ]; then \
			$(INSTALL) -m 0755 \
				-D ${PTXDIST_TOPDIR}/rules/$$PACKET.$$script \
				$(PKGDIR)/$$PACKET.tmp/ipkg/CONTROL/$$script; \
			echo "found in ptxdist, packaging"; \
		else \
			echo "not available"; \
		fi; fi; \
	done; \
	if [ -f "${PTXDIST_WORKSPACE}/rules/$$PACKET.preinst" ]; then \
		echo "install_init:   running preinst"; \
		DESTDIR=${ROOTDIR} /bin/sh ${PTXDIST_WORKSPACE}/rules/$$PACKET.preinst; \
	elif [ -f "${PTXDIST_TOPDIR}/rules/$$PACKET.preinst" ]; then \
		echo "install_init:   running preinst"; \
		DESTDIR=${ROOTDIR} /bin/sh ${PTXDIST_TOPDIR}/rules/$$PACKET.preinst; \
	fi;

#
# install_finish
#
# Finishes ipkg packet creation
#
# $1: packet label
#
install_finish = 												\
	export LANG=C; 												\
	PACKET=$(strip $(1));											\
	if [ ! -f $(STATEDIR)/$$PACKET.perms ]; then								\
		echo "Packet $$PACKET is empty. not generating";						\
		rm -rf $(PKGDIR)/$$PACKET.tmp;									\
		exit 0;												\
	fi;													\
	echo -n "install_finish: creating package directory ... ";						\
	(echo "pushd $(PKGDIR)/$$PACKET.tmp/ipkg;";								\
	awk -F: $(DOPERMISSIONS) $(STATEDIR)/$$PACKET.perms; echo "popd;"; 					\
	echo -n "echo \"install_finish: packaging ipkg packet ... \"; ";					\
	echo -n "$(PTXCONF_SYSROOT_HOST)/bin/ipkg-build "; 							\
	echo    "$(PTXCONF_IMAGE_IPKG_EXTRA_ARGS) $(PKGDIR)/$$PACKET.tmp/ipkg $(PKGDIR)") |$(FAKEROOT) -- 2>&1;	\
	$(CHECK_PIPE_STATUS)											\
	rm -rf $(PKGDIR)/$$PACKET.tmp;										\
	echo "done."; \
	\
	if [ -f "${PTXDIST_WORKSPACE}/rules/$$PACKET.postinst" ]; then \
		echo "install_finish: running postinst"; \
		DESTDIR=${ROOTDIR} /bin/sh ${PTXDIST_WORKSPACE}/rules/$$PACKET.postinst; \
	else if [ -f "${PTXDIST_TOPDIR}/rules/$$PACKET.postinst" ]; then \
		echo "install_finish: running postinst"; \
		DESTDIR=${ROOTDIR} /bin/sh ${PTXDIST_TOPDIR}/rules/$$PACKET.postinst; \
	fi; fi

#
# install_autoinstall
#
# Installs a file with user/group ownership and permissions via
# fakeroot.
#
# $1: packet label
# $2: UID
# $3: GID
# $4: permissions (octal)
# $5: source (for files); directory (for directories)
# $6: destination (for files); empty (for directories). Prefixed with $(ROOTDIR),
#     so it needs to have a leading /
# $7: strip (for files; y|n); default is to strip
#
install_autoinstall = 										\
	PACKET=$(strip $(1));									\
	PACKNAME=$(strip $(2));									\
	OWN=$(strip $(3));									\
	GRP=$(strip $(4));									\
	PER=$(strip $(5));									\
	SRC=$(strip $(6));									\
	DST=$(strip $(7));									\
	STRIP="$(strip $(8))";									\
	echo "install_autoinstall:";								\
	echo "  src=$$SRC";								\
	echo "  dst=$$DST";								\
	echo "  owner=$$OWN";								\
	echo "  group=$$GRP";								\
	echo "  permissions=$$PER"; 							\
	case "$$STRIP" in								\
	(0 | n | no)									\
		STRIPFLAG="";								\
		;;									\
	(*)										\
		STRIPFLAG="-i $(CROSS_STRIP)"; 						\
		;;									\
	esac;										\
	$(SCRIPTSDIR)/make_targetinstall.sh -p "$$SRC" -o $$OWN -g $$GRP -r $$PER -n $$PACKET -f $$PACKNAME -t "$(PTXDIST_WORKSPACE)/build-target" -d "$(PKGDIR)/$$PACKET.tmp/ipkg" $$STRIPFLAG;			\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_autoinstall failed!";				\
		exit 1;									\
	fi;										\
	$(SCRIPTSDIR)/make_targetinstall.sh -p "$$SRC" -o $$OWN -g $$GRP -r $$PER -n $$PACKET -f $$PACKNAME -t "$(PTXDIST_WORKSPACE)/build-target" -d "$(ROOTDIR)" -s $(STATEDIR) $$STRIPFLAG;			\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_autoinstall failed!";				\
		exit 1;									\
	fi;										\
	$(SCRIPTSDIR)/make_targetinstall.sh -p "$$SRC" -o $$OWN -g $$GRP -r $$PER -n $$PACKET -f $$PACKNAME -t "$(PTXDIST_WORKSPACE)/build-target" -d $(ROOTDIR_DEBUG);						\
	if [ $$? -ne 0 ]; then								\
		echo "Error: install_autoinstall failed!";				\
		exit 1;									\
	fi;										\
	mkdir -p $(PKGDIR)/$$PACKET.tmp;						\

# vim: syntax=make