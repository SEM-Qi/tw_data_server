%% Feel free to use, reuse and abuse the code in this file.

%% @doc POST echo handler.
-module(authorize_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	Pid = tag_riak:connect(),
	{ok, Req, Pid}.

handle(Req, Pid) ->
	{Method, Req2} = cowboy_req:method(Req),
	HasBody = cowboy_req:has_body(Req2),
	{ok, Req3} = store_info(Method, HasBody, Req2, Pid),
	{ok, Req3, Pid}.

store_info(<<"POST">>, true, Req, Pid) ->
	{ok, TestInfo, Req4} = cowboy_req:body(Req),
	Result = tag_riak:authorize(Pid, TestInfo),
	if Result =:= bad_request 
		 -> cowboy_req:reply(400, [], <<"Body format incorrect.">>, Req4);
	true -> cowboy_req:reply(200, [
				{<<"content-type">>, <<"text/plain; charset=utf-8">>}
			], Result, Req4)
	end;
	

store_info(<<"POST">>, false, Req, _) ->
	cowboy_req:reply(400, [], <<"Missing body.">>, Req);
store_info(_, _, Req, _) ->
	%% Method not allowed.
	cowboy_req:reply(405, Req).


terminate(_Reason, _Req, _State) ->
	ok.
