-module(geom).
-author("pmw").
-include_lib("eunit/include/eunit.hrl").

%% API
-export([area/3]).

area(rectangle, A, B) when (A>=0) and (B>=0) ->
  A * B;
area(triangle, A, B) when (A>=0) and (B>=0) ->
  A * B / 2;
area(ellipse, A, B) when (A>=0) and (B>=0) ->
  math:pi() * A * B.

within(X, Expected, Range) ->
  (X >= (Expected-Range)) and (X =< (Expected+Range)).

area_test_() -> [
  ?_assert(area(rectangle, 3, 4) =:= 12),
  ?_assert(area(triangle, 3, 5) =:= 7.5),
  ?_assert(within(area(ellipse, 3, 4), 37.7, 0.1)),
  ?_assertException(error, function_clause, area(rectangle, 3, -5)),
  ?_assertException(error, function_clause, area(triangle, 3, -5)),
  ?_assertException(error, function_clause, area(ellipse, 3, -5))
].
