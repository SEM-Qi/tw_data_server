%% @doc Hello world handler.
-module(taglist_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	Pid = tag_riak:connect(),
	{ok, Req, Pid}.

handle(Req, Pid) ->
	Body = tag_riak:update_taglist(Pid),
	{ok, Req1} = cowboy_req:reply(200, [
		{<<"content-type">>, <<"application/json">>}
	], Body, Req),
	{ok, Req1, Pid}.

terminate(_Reason, _Req, State) ->
	tag_riak:close_server(State),
	ok.
