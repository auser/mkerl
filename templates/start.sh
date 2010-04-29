#!/bin/sh

VERSION=<%= version %>
PWD=$(dirname $0)
DEPS_DIRS=$(find $PWD/deps -maxdepth 1 -mindepth 1 -type d | tr '\n' ' ')
PA_DIRS=$(for dir in $DEPS_DIRS; do echo "-pa $dir"; done)
CONFIG=$1

erl -pa $PWD/ebin \
    $PA_DIRS \
    -s reloader \
    -<%= name %> \
    -boot <%=name %>-$VERSION
