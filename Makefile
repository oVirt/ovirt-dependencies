PACKAGE_NAME=ovirt-dependencies
VERSION=4.4.2
MILESTONE=
ifneq ($(MILESTONE),)
SUFFIX:=_$(MILESTONE)
endif
PACKAGE_VERSION=$(VERSION)
PACKAGE_RPM_VERSION=$(VERSION)
PACKAGE_RPM_RELEASE=1

PREFIX=/usr/local
DATAROOTDIR=$(PREFIX)/share
JAVADIR=$(DATAROOTDIR)/java
APPJAVADIR=$(JAVADIR)/$(PACKAGE_NAME)
OFFLINE=0

.SUFFIXES:
.SUFFIXES: .in .in.in

%.in.in%.in:

all:		\
		download \
		doc \
		$(NULL)

maintainer-clean:	dist-clean
	rm -fr downloads

dist-clean:	clean

clean:
	rm -f downloads/downloads.list
	rm -f ovirt-dependencies.spec
	rm -f COPYING
	rm -f COPYING.csv
	rm -f *.tmp

install:	all
	install -d -m 0755 "$(DESTDIR)$(APPJAVADIR)"
	./install.sh downloads "$(DESTDIR)$(APPJAVADIR)"

.PHONY: ovirt-dependencies.spec.in.in
dist:		\
		download \
		ovirt-dependencies.spec \
		$(NULL)

	git ls-files | tar --files-from /proc/self/fd/0 --files-from downloads/downloads.list \
		--xform 's#^#$(PACKAGE_NAME)-$(PACKAGE_VERSION)/#' \
		-czf "$(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(PACKAGE_RPM_RELEASE).tar.gz" \
		ovirt-dependencies.spec \
		$(NULL)

download:	downloads/downloads.list

downloads/downloads.list:	\
		conf.d/*.conf
	if [ "$(OFFLINE)" = 0 ]; then \
		./download.sh downloads; \
	fi

doc:		\
		COPYING \
		COPYING.csv \
		$(NULL)

COPYING:	\
		conf.d/*.conf
	./doc.sh COPYING

COPYING.csv:	\
		conf.d/*.conf
	./csv.sh COPYING.csv

ovirt-dependencies.spec:	ovirt-dependencies.spec.in
	sed \
		-e "s/@PACKAGE_LICENSE@/$$(./speclicense.sh)/g" \
		$< > $@

.in .in.in.in:
	sed \
		-e 's/@PACKAGE_NAME@/$(PACKAGE_NAME)/g' \
		-e 's/@PACKAGE_VERSION@/$(PACKAGE_VERSION)/g' \
		-e 's/@PACKAGE_RPM_VERSION@/$(PACKAGE_RPM_VERSION)/g' \
		-e 's/@PACKAGE_RPM_RELEASE@/$(PACKAGE_RPM_RELEASE)/g' \
		$< > $@

update-sha1sum:
	sha1sum --binary downloads/* > downloads.sha1
