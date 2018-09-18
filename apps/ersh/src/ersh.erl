-module(ersh).

-export([main/1]).

-define(ME, filename:basename(escript:script_name())).

main(_) -> shell().

run(Command, Args) ->
    ArgString = lists:foldl(fun (A, B) -> A ++ " " ++ B end,
			    "", Args),
    os:cmd(Command ++ " " ++ ArgString).

shell() ->
    net_kernel:start([my_name(), shortnames]),
    erlang:set_cookie(my_name(), ershd_cookie),
    io:fwrite("~s\n", [node()]),
    spawn(ershd_name("denis-pc"), ershd_app, hello, []),
    Input = io:get_line("$>"),
    Output = os:cmd(Input),
    io:fwrite(Output),
    shell().

my_name() ->
    Localhost = net_adm:localhost(),
    list_to_atom((?ME) ++ "@" ++ Localhost).

ershd_name(Host) -> list_to_atom("ershd@" ++ Host).
