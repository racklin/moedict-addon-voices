#!/bin/bash

CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PACKAGENAME="moedict-voice"
VERSION="1.0.0"

DISTDIR="$CALLDIR/dist"

if [ ! -d "$DISTDIR" ]; then mkdir -p "$DISTDIR"; fi

build_mandarin() {

    echo ""
    echo "Building mandarin ... "

    cp -f install_a.rdf install.rdf
    cp -f chrome_a.manifest chrome.manifest

    zip -rqX "$DISTDIR/${PACKAGENAME}-a-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_a.js voices/a/

    cd $CALLDIR
}

build_taiwanese() {

    echo ""
    echo "Building taiwanese ... "

    cp -f install_t.rdf install.rdf
    cp -f chrome_t.manifest chrome.manifest

    zip -rqX "$DISTDIR/${PACKAGENAME}-t-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_t.js voices/t/

    cd $CALLDIR
}

build_hakka() {

    echo ""
    echo "Building hakka ... "

    cp -f install_h.rdf install.rdf
    cp -f chrome_h.manifest chrome.manifest

    zip -rqX "$DISTDIR/${PACKAGENAME}-h-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_h.js voices/h/

    cd $CALLDIR
}

while getopts "ath" opt; do
	case $opt in
		a)
                        build_mandarin
			;;
		t)
			build_taiwanese
			;;
		h)
			build_hakka
			;;
		*)
                        echo "build all"
			;;
	esac
	shift $((OPTIND-1)); OPTIND=1
done

