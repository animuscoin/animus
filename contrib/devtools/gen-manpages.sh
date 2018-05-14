#!/bin/bash

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ANSD=${ANSD:-$BINDIR/animusd}
ANSCLI=${ANSCLI:-$BINDIR/animus-cli}
ANSTX=${ANSTX:-$BINDIR/animus-tx}
ANSQT=${ANSQT:-$BINDIR/qt/animus-qt}

[ ! -x $ANSD ] && echo "$ANSD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($ANSCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for animusd if --version-string is not set,
# but has different outcomes for animus-qt and animus-cli.
echo "[COPYRIGHT]" > footer.h2m
$ANSD --version | sed -n '1!p' >> footer.h2m

for cmd in $ANSD $ANSCLI $ANSTX $ANSQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
