%% @doc Hello world handler.
-module(attack_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	Pid = tag_riak:connect(),
	{ok, Req, Pid}.

handle(Req, Pid) ->
	case cowboy_req:qs_val(<<"tag">>, Req) of
		{undefined, Req2} ->
			{ok, Req3} = cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req2),
			{ok, Req3, Pid};
		{Tag, Req2} ->
			Tagnum = tag_riak:tag_attack(Pid, Tag),
			{ok, Req3} = cowboy_req:reply(200, [
				{<<"content-type">>, <<"application/json">>}
			], Tagnum, Req2),
			{ok, Req3, Pid}
	end.

terminate(_Reason, _Req, State) ->
	tag_riak:close_server(State),
	ok.










