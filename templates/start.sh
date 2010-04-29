#!/bin/sh

VERSION=$(cat VERSION | tr -d '\n')
PWD=$(dirname $0)
CONFIG=$1

erl -pa $PWD/ebin \
    -s reloader \
    -<%= name %> \
    -boot <%=name %>-<%= version %>