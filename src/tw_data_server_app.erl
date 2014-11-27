-module(tw_data_server_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", connection_handler, []},
			{"/deeper", deeper_handler, []},
			{"/updatelist", taglist_handler, []},
			{"/tagattack", attack_handler, []},
			{"/testpost", testpost_handler, []},
			{"/setkey", setkey_handler, []},
			{"/getuserinfo", getuserinfo_handler, []},
			{"/authorize", authorize_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
		{env, [{dispatch, Dispatch}]}
		% ,
		% {middlewares, [cowboy_router, directory_lister, cowboy_handler]}
	]),
	tw_data_server_sup:start_link().
stop(_State) ->
    ok.
