-module(powers).
-author("pmw").
-include_lib("eunit/include/eunit.hrl").

-export([nth_root/2]).

nth_root(X, N) ->
  nth_root(X, N, X / 2.0).

nth_root(X, N, Approx) ->
  F = math:pow(Approx, N) - X,
  Fprime = N * math:pow(Approx, N-1),
  Next = Approx - F / Fprime,
  Change = abs(Next - Approx),
  io:format("Current guess is ~f~n", [Next]),
  if
    Change < 1.0e-8 ->
      Next;
    true ->
      nth_root(X, N, Next)
  end.

nth_root_test_() -> [
  ?_assert(nth_root(27, 3) =:= 3.0)
].
