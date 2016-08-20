-module(dijkstra).
-author("pmw").
-include_lib("eunit/include/eunit.hrl").

-export([gcd/2]).

gcd(M, N) ->
  if
    M =:= N ->
      M;
    M > N ->
      gcd(M-N, N);
    true ->
      gcd(M, N-M)
  end.

gcd_test_() -> [
  ?_assert(gcd(12, 8) =:= 4),
  ?_assert(gcd(14, 21) =:= 7),
  ?_assert(gcd(125, 46) =:= 1),
  ?_assert(gcd(120, 36) =:= 12)
].
