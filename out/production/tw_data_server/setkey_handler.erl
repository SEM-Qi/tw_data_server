%%%-------------------------------------------------------------------
%%% @author gabriele
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. Nov 2014 18:49
%%%-------------------------------------------------------------------
-module(setkey_handler).
-author("gabriele").

%% API

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {ok, Req1} = cowboy_req:reply(200, [
    {<<"content-type">>, <<"text/plain">>}
  ], "fuck you fuck you fuck you", Req),
  {ok, Req1, State}.

terminate(_Reason, _Req, _State) ->
  ok.