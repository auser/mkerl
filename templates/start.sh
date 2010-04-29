#!/bin/sh

VERSION=<%= version %>
PWD=$(dirname $0)
CONFIG=$1

erl -pa $PWD/ebin \
    -s reloader \
    -<%= name %> \
    -boot <%=name %>-$VERSION