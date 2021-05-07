
die() {
	local m="$1"
	echo "FATAL: ${m}" >&2
	exit 1
}

common_iterate() {
	local perconf="$1"
	local perfile="$2"

	find conf.d -name '*.conf' | sort | while read c; do
		(
			. "${c}"

			echo "${DESCRIPTION}" >&2

			${perconf}

			artifact_index=0
			while true; do
				eval extract="\${EXTRACT${artifact_index}}"
				eval artifact="\${ARTIFACT${artifact_index}}"
				[ -z "${artifact}" ] && break

				${perfile}

				artifact_index="$((${artifact_index}+1))"
			done
		) || exit 1
	done || exit 1
}

common_void() {
	return 0
}
