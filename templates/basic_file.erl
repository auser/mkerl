% 
%  <%= name %>
% 
-module (<%= name %>).

-export ([
  start_link/1
]).

start_link(_) ->
  erlang:display(start),
  {ok, self()}.