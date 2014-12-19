%% ------------------------------------------------------------------
%% taglist_handler manages the request for user information
%% ------------------------------------------------------------------

-module(taglist_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

%% on recieving a request, the handler's init function is called. 
%% Everything is done with call backs so you need to return as you see below
%% {ok, Req, State} Req = the request object that has come in, 
%% init is also calls tag_riak:connect(Player) 
%% (where player information is available) and this returns 
%% the pid of the process that all future tag_riak calls by this process will be made to


init(_Transport, Req, []) ->
	case cowboy_req:qs_val(<<"player">>, Req) of
		{undefined, Req2} -> 
			Pid = tag_riak:connect(),
			{ok, Req2, Pid};
		{Player, Req2} ->
			Pid = tag_riak:connect(Player),
			{ok, Req2, Pid}
	end.

%% Simplest function is the handle function. Called on any request
%% Most important thing to remember is that any operation performed on the 
%% Req object must be passed to a new variable, even read operations return a new Req object

handle(Req, Pid) ->
	Body = tag_riak:update_taglist(Pid),
	{ok, Req1} = cowboy_req:reply(200, [
		{<<"content-type">>, <<"application/json">>}
	], Body, Req),
	{ok, Req1, Pid}.

%% when the connection is closed, terminate is called. 
%% do any cleanup (like closing processes) here.

terminate(_Reason, _Req, State) ->
	tag_riak:close_server(State),
	ok.
