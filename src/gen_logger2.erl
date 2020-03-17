-module(gen_logger2).

-export([ debug/1
        , debug/2
        , info/1
        , info/2
        , warning/1
        , warning/2
        , error/1
        , error/2
        , critical/1
        , critical/2 ]).

-export([ set_logger/2
        , get_logger/0 ]).

debug(Msg)       -> do_log(get_logger(), debug, Msg).
debug(Fmt, Args) -> do_log(get_logger(), debug, Fmt, Args).

info(Msg)       -> do_log(get_logger(), info, Msg).
info(Fmt, Args) -> do_log(get_logger(), info, Fmt, Args).

warning(Msg)       -> do_log(get_logger(), warning, Msg).
warning(Fmt, Args) -> do_log(get_logger(), warning, Fmt, Args).

error(Msg)       -> do_log(get_logger(), error, Msg).
error(Fmt, Args) -> do_log(get_logger(), error, Fmt, Args).

critical(Msg)       -> do_log(get_logger(), critical, Msg).
critical(Fmt, Args) -> do_log(get_logger(), critical, Fmt, Args).

set_logger(Module, Level) ->
    put({?MODULE, logger}, {Module, Level}).

get_logger() ->
    case get({?MODULE, logger}) of
        undefined ->
            {console_logger, debug};
        {_, _} = Logger ->
            Logger
    end.

do_log({Logger, Level}, F, Msg) ->
    gen_logger:F(Msg, {gen_lgger, Logger, Level}).

do_log({Logger, Level}, F, Fmt, Args) ->
    gen_logger:F(Fmt, Args, {gen_logger, Logger, Level}).
