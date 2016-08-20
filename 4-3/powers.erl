-module(powers).
-author("pmw").
-include_lib("eunit/include/eunit.hrl").

-export([raise/2]).

% raise(X, N) = X^N
raise(_, 0) -> 1;
raise(X, 1) -> X;
raise(X, N) when N>0 ->
  X * raise(X, N-1);
raise(X, N) when N<0 ->
  1.0 / raise(X, -N).

raise_test_() -> [
  ?_assert(raise(5, 1) =:= 5),
  ?_assert(raise(2, 3) =:= 8),
  ?_assert(raise(1.2, 3) =:= 1.728),
  ?_assert(raise(2, 0) =:= 1),
  ?_assert(raise(2, -3) =:= 0.125)
].
