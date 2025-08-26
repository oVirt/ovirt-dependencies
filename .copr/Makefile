# outdir: passed by copr telling where to save the src.rpm
# spec: passed by copr telling which spec file should be used;
#       using for selecting the right src.rpm to be copied.

.PHONY: installdeps git_cfg_safe srpm

installdeps:
	dnf -y install coreutils curl dnf-utils findutils git java-21-openjdk-devel make maven rpmdevtools sed

git_cfg_safe:
	# From git 2.35.2 we need to mark temporary directory, where the project is cloned to, as safe, otherwise
	# git commands won't work because of the fix for CVE-2022-24765
	git config --global --add safe.directory "$(shell pwd)"

srpm: installdeps git_cfg_safe
	.automation/build-srpm.sh
	find . -name '*.src.rpm' -exec cp {} $(outdir) \;
