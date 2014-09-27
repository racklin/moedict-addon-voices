#!/bin/bash

A_INDEX="http://a.moedict.tw/index.ogg.txt"
T_INDEX="http://t.moedict.tw/index.ogg.txt"
H_INDEX="http://h.moedict.tw/index.ogg.txt"

CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


fetch_mandarin() {
    echo ""
    echo "Downloading mandarin ... "
    mkdir -p $CALLDIR/voices/a
    cd $CALLDIR/voices/a

    curl -O $A_INDEX

    for file in `cat $CALLDIR/voices/a/index.ogg.txt`
    do
        curl -O $file
    done
    cd $CALLDIR
}

fetch_taiwanese() {
    echo ""
    echo "Downloading Taiwanese ... "
    mkdir -p $CALLDIR/voices/t
    cd $CALLDIR/voices/t

    curl -O $T_INDEX

    for file in `cat $CALLDIR/voices/t/index.ogg.txt`
    do
        curl -O $file
    done
    cd $CALLDIR
}

fetch_hakka() {
    echo ""
    echo "Downloading Hakka ... "
    mkdir -p $CALLDIR/voices/h
    cd $CALLDIR/voices/h

    curl -O $H_INDEX

    for file in `cat $CALLDIR/voices/h/index.ogg.txt`
    do
        curl -O $file
    done
    cd $CALLDIR
}

while getopts "ath" opt; do
	case $opt in
		a)
                        fetch_mandarin
			;;
		t)
			fetch_taiwanese
			;;
		h)
			fetch_hakka
			;;
		*)
                        echo "fetch all"
			;;
	esac
	shift $((OPTIND-1)); OPTIND=1
done

