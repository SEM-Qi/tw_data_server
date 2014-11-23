-module(connection_handler).
-export([init/3, handle/2, terminate/3]).

init(_Transport, Req, _Opts) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {ok, Reply} = cowboy_req:reply(
        302,
        [{<<"Location">>, <<"http://picard.chalmers.skip.se/updatelist">>}],
        <<"Redirecting with Header!">>,
        Req
    ),
    {ok, Reply, State}.

terminate(_Reason, _Req, _State) ->
    ok.