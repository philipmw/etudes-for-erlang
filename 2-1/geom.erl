-module(geom).
-author("pmw").
-include_lib("eunit/include/eunit.hrl").

%% API
-export([area/2]).

area(X, Y) -> X * Y.
area_test() -> 50 = geom:area(5, 10).