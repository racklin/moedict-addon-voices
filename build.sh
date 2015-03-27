#!/bin/bash

CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PACKAGENAME="moedict-voice"
VERSION="1.1.1"

DISTDIR="$CALLDIR/dist"

if [ ! -d "$DISTDIR" ]; then mkdir -p "$DISTDIR"; fi

build_mandarin() {

    echo ""
    echo "Building mandarin ... "

    rm -f $DISTDIR/${PACKAGENAME}-a*.xpi

    # part 1
    cp -f install_a1.rdf install.rdf
    cp -f chrome_a1.manifest chrome.manifest
    zip -rqX "$DISTDIR/${PACKAGENAME}-a1-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_a1.js a01.jar

    # part 2
    cp -f install_a2.rdf install.rdf
    cp -f chrome_a2.manifest chrome.manifest
    zip -rqX "$DISTDIR/${PACKAGENAME}-a2-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_a2.js a23.jar

    # part 3
    cp -f install_a3.rdf install.rdf
    cp -f chrome_a3.manifest chrome.manifest
    zip -rqX "$DISTDIR/${PACKAGENAME}-a3-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_a3.js a456.jar

    cd $CALLDIR
}

build_taiwanese() {

    echo ""
    echo "Building taiwanese ... "

    cp -f install_t.rdf install.rdf
    cp -f chrome_t.manifest chrome.manifest

    rm -f $DISTDIR/${PACKAGENAME}-t-*.xpi
    zip -rqX "$DISTDIR/${PACKAGENAME}-t-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_t.js t.jar

    cd $CALLDIR
}

build_hakka() {

    echo ""
    echo "Building hakka ... "

    rm -f $DISTDIR/${PACKAGENAME}-h*.xpi

    # part 1
    cp -f install_h1.rdf install.rdf
    cp -f chrome_h1.manifest chrome.manifest
    zip -rqX "$DISTDIR/${PACKAGENAME}-h1-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_h1.js h123.jar

    # part 2
    cp -f install_h2.rdf install.rdf
    cp -f chrome_h2.manifest chrome.manifest
    zip -rqX "$DISTDIR/${PACKAGENAME}-h2-${VERSION}.xpi" install.rdf chrome.manifest defaults/preferences/voice_h2.js h45.jar

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

