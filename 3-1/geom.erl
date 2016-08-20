-module(geom).
-author("pmw").
-include_lib("eunit/include/eunit.hrl").

%% API
-export([area/3]).

area(rectangle, A, B) -> A * B;
area(triangle, A, B) -> A * B / 2;
area(ellipse, A, B) -> math:pi() * A * B.

within(X, Expected, Range) ->
  (X >= (Expected-Range)) and (X =< (Expected+Range)).

area_test_() -> [
  ?_assert(area(rectangle, 3, 4) =:= 12),
  ?_assert(area(triangle, 3, 5) =:= 7.5),
  ?_assert(within(area(ellipse, 3, 4), 37.7, 0.1))
].