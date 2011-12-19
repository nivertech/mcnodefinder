%% @doc Nodefinder service.
%% @end

-module (nodefinder_mc_app).
-export ([ discover/0 ]).

-behaviour(application).
-export ([ start/0, start/2, stop/0, stop/1 ]).

-define(APPLICATION, nodefinder_mc).

%-=====================================================================-
%-                                Public                               -
%-=====================================================================-

%% @doc Initiate a discovery request.  Nodes will respond asynchronously
%% and be added to the erlang node list subsequent to this call returning.
%% @end
-spec discover() -> ok.
discover() ->
  nodefinder_mc_srv:discover().

%-=====================================================================-
%-                        application callbacks                        -
%-=====================================================================-

%% @hidden

start() ->
  crypto:start(),
  application:start(?APPLICATION).

%% @hidden

start (_Type, _Args) ->
  { ok, Addr }	= application:get_env(?APPLICATION, addr),
  { ok, Port }	= application:get_env(?APPLICATION, port),
  { ok, Ttl }	= application:get_env(?APPLICATION, multicast_ttl),
  nodefinder_mc_sup:start_link(Addr, Port, Ttl).

%% @hidden

stop() ->
  application:stop(?APPLICATION).

%% @hidden

stop(_State) ->
  ok.

