# oVirt dependencies

[![Copr build status](https://copr.fedorainfracloud.org/coprs/ovirt/ovirt-master-snapshot/package/ovirt-dependencies/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ovirt/ovirt-master-snapshot/package/ovirt-dependencies/)

Welcome to the oVirt Engine dependencies packaging repository.
This package provides pre-built java dependencies for ovirt-engine.

This repository contains scripts to create WildFly RPM package from officially released ZIP file, which required to run oVirt Engine.

## How to contribute

All contributions are welcome - patches, bug reports, and documentation issues.

### Submitting patches

Please submit patches to [GitHub:ovirt-dependencies](https://github.com/oVirt/ovirt-dependencies)
 If you are not familiar with the process, you can read about [collaborating with pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests) on the GitHub website.

### Found a bug or documentation issue?
To submit a bug or suggest an enhancement for oVirt Engine WildFly please use
[oVirt Bugzilla for ovirt-distribution product and ovirt-dependencies component](https://bugzilla.redhat.com/enter_bug.cgi?product=ovirt-distribution&component=ovirt-dependencies).

If you don't have a Bugzilla account, you can still report [issues](https://github.com/oVirt/ovirt-dependencies/issues).

## Still need help?

If you have any other questions or suggestions, you can join and contact us on the [oVirt Users forum / mailing list](https://lists.ovirt.org/admin/lists/users.ovirt.org/).


## Maintainers guide

### Versioning

Bump version in `Makefile` <br>
TODO: Make it consistent with other java/maven based projects

### Building RPM

    make clean
    make dist
    rpmbuild -tb ovirt-dependencies-<VERSION_TAG>.tar.gz

### Add or remove a dependency for runtime package

1. Update `pom.xml.in` with requested dependencies.
2. Make sure to add or update artifact at `conf.d/*.conf`
3. Add/remove `%mvn_artifact` under `%install` section of `ovirt-dependencies.spec.in`

