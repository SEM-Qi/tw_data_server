-module(tw_data_server_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================


%% Define new paths and what handler will deal with the request as per the below.
%% i.e. {"/doesthing", doesthing_handler, []}
%% use taglist_handler as a basic example of how to build a handler.

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", connection_handler, []},
			{"/deeper", deeper_handler, []},
			{"/updatelist", taglist_handler, []},
			{"/tagattack", attack_handler, []},
			{"/testpost", testpost_handler, []},
			{"/setkey", setkey_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 80}], [
		{env, [{dispatch, Dispatch}]}
	]),
	tw_data_server_sup:start_link().
stop(_State) ->
    ok.
