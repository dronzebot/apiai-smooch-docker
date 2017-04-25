#!/usr/bin/env bash

VENVNAME="dronze-agent"
BASEDIR=`dirname $0`/..
REQUIREMENTS=`dirname $0`/requirements.txt

echo "BASEDIR: ${BASEDIR}"

if [ ! -d "$BASEDIR/ve" ]; then
    virtualenv -q $BASEDIR/ve-$VENVNAME --system-site-packages
    echo "Virtualenv ve-$VENVNAME created as a peer to this project."
fi

if [ ! -f "$BASEDIR/ve-$VENVNAME/updated" -o $REQUIREMENTS -nt $BASEDIR/ve-$VENVNAME/updated ]; then
    source "$BASEDIR/ve-$VENVNAME/bin/activate"
    echo "virtualenv ve-$VENVNAME activated."

    pip install --upgrade pip

    pip install -r $REQUIREMENTS
    touch $BASEDIR/ve-$VENVNAME/updated
    echo "Requirements installed."

    python -m spacy download en
    echo "Spacy modules installed."
fi
