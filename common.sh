
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

			urlindex=0
			while true; do
				eval url="\${URL${urlindex}}"
				eval extract="\${EXTRACT${urlindex}}"
				eval artifact="\${ARTIFACT${urlindex}}"
				[ -z "${url}" ] && break

				${perfile}

				urlindex="$((${urlindex}+1))"
			done
		) || exit 1
	done || exit 1
}

common_void() {
	return 0
}
