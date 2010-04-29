%%%-------------------------------------------------------------------
%%% File    : <%= name %>_sup.erl
%%% Author  : Your name
%%% Description : 
%%%
%%% Created :  <%= created_at %>
%%%-------------------------------------------------------------------

-module(<%= name %>_sup).
-behaviour(supervisor).

%% API
-export([
  start_link/0,
  start_link/1
]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================  
%%--------------------------------------------------------------------
%% Function: start_link() -> {ok,Pid} | ignore | {error,Error}
%% Description: Starts the supervisor
%%--------------------------------------------------------------------
start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_link(Opts) ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, [Opts]).

%%====================================================================
%% Supervisor callbacks
%%====================================================================
%%--------------------------------------------------------------------
%% Func: init(Args) -> {ok,  {SupFlags,  [ChildSpec]}} |
%%                     ignore                          |
%%                     {error, Reason}
%% Description: Whenever a supervisor is started using
%% supervisor:start_link/[2,3], this function is called by the new process
%% to find out about restart strategy, maximum restart frequency and child
%% specifications.
%%--------------------------------------------------------------------
init([Opts]) ->
  AppSrv = {the_<%= name %>,{<%= name %>, start_link, [Opts]}, permanent,2000,worker,dynamic},
  {ok,{{one_for_one,5,10}, [AppSrv]}}.

%%====================================================================
%% Internal functions
%%====================================================================