
%% ------------------------------------------------------------------
%% tw_data_server is an OTP style application that handles http requests 
%% from the clients in the tagwars system 
%% It is built off the Cowboy webserver technology https://github.com/ninenines/cowboy
%% A lightweight, OTP compliant application, 
%% Cowboy allows w_data_server to be highly scalable and super responsive.
%% Like many OTP applications it spawns a new process to handle each connection, 
%% so for example, if 50 people connect to /taglist, 50 taglist_hanlder processes 
%% (similar to gen_servers) are spawned
%% As the handlers are similar in function see taglist_handler as a more detailed
%% example of how a handler works.
%% ------------------------------------------------------------------

-module(tw_data_server_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================


%% Define paths and what handler will deal with the request as per the below.
%% i.e. {"/doesthing", doesthing_handler, []}
%% Also define port here.

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/crossdomain.xml", cowboy_static, {priv_file, tw_data_server, "static/crossdomain.xml", [
				{mimetypes, cow_mimetypes, all}
			]}},
			{"/updatelist", taglist_handler, []},
			{"/tagattack", attack_handler, []},
			{"/setkey", setkey_handler, []},
			{"/getuserinfo", getuserinfo_handler, []},
			{"/updatekey", updatekey_handler, []},
			{"/authorize", authorize_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 80}], [
		{env, [{dispatch, Dispatch}]}
	]),
	tw_data_server_sup:start_link().
stop(_State) ->
    ok.
