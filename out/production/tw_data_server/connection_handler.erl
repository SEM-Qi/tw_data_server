%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(connection_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
	{ok, Req1} = cowboy_req:reply(200, [
		{<<"content-type">>, <<"text/plain">>}
	], "Hi", Req),
	{ok, Req1, State}.

terminate(_Reason, _Req, _State) ->
	ok.