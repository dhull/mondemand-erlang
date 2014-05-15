-module (mondemand_app).

-behaviour (application).

%% API
-export([start/0]).

%% Application callbacks
-export([start/2, stop/1]).

%-=====================================================================-
%-                                  API                                -
%-=====================================================================-
start() ->
  [ ensure_started (App)
    || App
    <- [sasl, lwes, mondemand]
  ].

%-=====================================================================-
%-                        application callbacks                        -
%-=====================================================================-
start(_Type, _StartArgs) ->
  mondemand_sup:start_link().

stop(_State) ->
    ok.

%-=====================================================================-
%-                               Private                               -
%-=====================================================================-
ensure_started(App) ->
  case application:start(App) of
    ok ->
      ok;
    {error, {already_started, App}} ->
      ok
  end.

%-=====================================================================-
%-                            Test Functions                           -
%-=====================================================================-
-ifdef (TEST).
-include_lib ("eunit/include/eunit.hrl").

-endif.
