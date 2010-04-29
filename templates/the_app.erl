%%%-------------------------------------------------------------------
%%% File    : <%= name %>_app.erl
%%% Author  : Your name
%%% Description : 
%%%
%%% Created :  <%= created_at %>
%%%-------------------------------------------------------------------

-module (<%= name %>_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, Args) -> 
  <%= name %>_sup:start_link(Args).

stop(_State) -> 
  io:format("Stopping <%= name %>...~n"),
  ok.
