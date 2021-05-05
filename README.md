oVirt dependencies
------------------
[![Copr build status](https://copr.fedorainfracloud.org/coprs/ovirt/ovirt-master-snapshot/package/ovirt-dependencies/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ovirt/ovirt-master-snapshot/package/ovirt-dependencies/)

This package provides pre-built java dependencies for ovirt-engine.

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

