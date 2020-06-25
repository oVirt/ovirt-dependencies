#!/bin/sh

. ./common.sh

csvline() {
	cat >> "${TMPCSV}" << __EOF__
"ovirt(ASL 2.0)","${NAME}","${VERSION}","${LICENSE}","${DESCRIPTION}","${HOME}","ovirt-dependencies"
__EOF__
}

CSV="$1"
[ -n "${CSV}" ] || die "Invalid usage"
TMPCSV="${CSV}.tmp"

rm -f "${CSV}" "${TMPCSV}"
cat > "${TMPCSV}" << __EOF__
"Required by","Name","Version","License","Summary","URL","Repository"
__EOF__
common_iterate csvline common_void
mv "${TMPCSV}" "${CSV}"
