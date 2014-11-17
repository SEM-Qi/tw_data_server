%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(deeper_handler).

-export([init/3]).
-export([content_types_provided/2]).
-export([hello_to_html/2]).
-export([hello_to_json/2]).
-export([hello_to_text/2]).

init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

content_types_provided(Req, State) ->
	{[
		{<<"text/html">>, hello_to_html},
		{<<"application/json">>, hello_to_json},
		{<<"text/plain">>, hello_to_text}
	], Req, State}.

hello_to_html(Req, State) ->
	Body = <<"<html>
<head>
	<meta charset=\"utf-8\">
	<title>REST Look into my eyes, World!</title>
</head>
<body>
	<p>REST Deeper into the depths, World!</p>
</body>
</html>">>,
	{Body, Req, State}.

hello_to_json(Req, State) ->
	Body = <<"{\"rest\": \"Deeper into the depths, World!\"}">>,
	{Body, Req, State}.

hello_to_text(Req, State) ->
	{<<"REST Deeper into the depths, World!">>, Req, State}.