PACKAGE_NAME=ovirt-dependencies
VERSION=4.5.2
MILESTONE=master
ifneq ($(MILESTONE),)
SUFFIX:=_$(MILESTONE)
endif
PACKAGE_VERSION=$(VERSION)
PACKAGE_RPM_VERSION=$(VERSION)
PACKAGE_RPM_RELEASE=0.0

PREFIX=/usr/local
DATAROOTDIR=$(PREFIX)/share
JAVADIR=$(DATAROOTDIR)/java
APPJAVADIR=$(JAVADIR)/$(PACKAGE_NAME)

# dependencies start
SPRING_VERSION=5.0.4
GWT_VERSION=2.9.0
POSTGRESQL_JDBC_VERSION=42.2.10
POSTGRESQL_JDBC_PARENT_VERSION=1.1.6
# dependencies stop

all:	\
	dist \
	$(NULL)

clean:	\
	pom.xml \
	clean-generated \
	$(NULL)

clean-generated:
	rm -f ovirt-dependencies.spec
	rm -f COPYING
	rm -f COPYING.csv
	rm -rf dependencies
	rm -f *.tmp
	rm -f doc

.PHONY: ovirt-dependencies.spec.in
.PHONY: pom.xml.in

dist:	\
	doc \
	pom.xml \
	maven_dist \
	dependencies_list \
	ovirt-dependencies.spec \
	$(NULL)

	git ls-files | tar --files-from /proc/self/fd/0 --files-from dependencies/dependencies.list \
		--xform 's#^#$(PACKAGE_NAME)-$(PACKAGE_VERSION)/#' \
		-czf "$(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(PACKAGE_RPM_RELEASE).tar.gz" \
		ovirt-dependencies.spec \
		pom.xml \
		COPYING \
		COPYING.csv \
		$(NULL)

maven_dist:
	mvn -C -Pdist package

dependencies_list:
	find dependencies -name \*.jar -o -name \*.pom > dependencies/dependencies.list

doc:	\
	COPYING \
	COPYING.csv \
	$(NULL)

COPYING:	\
	conf.d/*.conf
	./doc.sh COPYING

COPYING.csv:	\
	conf.d/*.conf
	./csv.sh COPYING.csv

pom.xml: pom.xml.in
	sed \
		-e 's/@PACKAGE_NAME@/$(PACKAGE_NAME)/g' \
		-e 's/@PACKAGE_VERSION@/$(PACKAGE_VERSION)/g' \
		-e 's/@SPRING_VERSION@/$(SPRING_VERSION)/g' \
		-e 's/@GWT_VERSION@/$(GWT_VERSION)/g' \
		-e 's/@POSTGRESQL_JDBC_VERSION@/$(POSTGRESQL_JDBC_VERSION)/g' \
		$< > $@

ovirt-dependencies.spec:	ovirt-dependencies.spec.in
	sed \
		-e "s/@PACKAGE_LICENSE@/$$(./speclicense.sh)/g" \
		-e 's/@PACKAGE_NAME@/$(PACKAGE_NAME)/g' \
		-e 's/@PACKAGE_VERSION@/$(PACKAGE_VERSION)/g' \
		-e 's/@PACKAGE_RPM_VERSION@/$(PACKAGE_RPM_VERSION)/g' \
		-e 's/@PACKAGE_RPM_RELEASE@/$(PACKAGE_RPM_RELEASE)/g' \
		-e 's/@SPRING_VERSION@/$(SPRING_VERSION)/g' \
		-e 's/@GWT_VERSION@/$(GWT_VERSION)/g' \
		-e 's/@POSTGRESQL_JDBC_VERSION@/$(POSTGRESQL_JDBC_VERSION)/g' \
		-e 's/@POSTGRESQL_JDBC_PARENT_VERSION@/$(POSTGRESQL_JDBC_PARENT_VERSION)/g' \
		$< > $@
