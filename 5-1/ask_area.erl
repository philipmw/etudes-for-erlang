-module(ask_area).
-author("pmw").

-export([area/0]).

area() ->
  Shape = get_shape(),
  {DimSt, DimVal} = case Shape of
             rectangle -> get_dimensions("width", "height");
             triangle -> get_dimensions("base", "height");
             ellipse -> get_dimensions("major axis", "minor axis")
           end,
  if
    DimSt =:= ok ->
      {A, B} = DimVal,
      calculate(Shape, A, B);
    true ->
      put_line(
        lists:flatten(
          string:concat("Cannot calculate because: ", DimVal))),
      error
  end.

put_line(Str) ->
  io:format("~p~n", [Str]).

get_shape() ->
  ShapeStr = trim(io:get_line("R)ectangle, T)riangle, or E)llipse? > ")),
  Shape = char_to_shape(ShapeStr),
  if
    Shape =:= unknown ->
      io:format("That's an invalid shape.  Please retry.~n"),
      get_shape();
    true ->
      Shape
  end.

char_to_shape(Char) ->
  case string:to_lower(Char) of
    "r" -> rectangle;
    "t" -> triangle;
    "e" -> ellipse;
    _ -> unknown
  end.

trim(Str) ->
  string:strip(Str, right, $\n).

% Returns either {ok, N} or {error, msg}
str_to_num(Str) ->
  case string:to_float(Str) of
    {error, _} ->
      {Int, Rest} = string:to_integer(Str),
      if
        Int =:= error ->
          {error, Rest};
        length(Rest) > 0 ->
          {error, "input has unparsed tail"};
        Int < 0 ->
          {error, "number is negative"};
        true ->
          {ok, Int}
      end;
    {Float, _} ->
      if
        Float < 0 ->
          {error, "number is negative"};
        true ->
          {ok, Float}
      end
  end.

% Returns either {ok, N}, or {error, msg}
get_nonneg_number(Prompt) ->
  str_to_num(
    trim(
      io:get_line(
        io_lib:format("Enter ~p > ", [Prompt])))).

% Returns either {ok, {A, B}} or {error, msg}
get_dimensions(PromptA, PromptB) ->
  {As, An} = get_nonneg_number(PromptA),
  {Bs, Bn} = get_nonneg_number(PromptB),
  if
    (As =:= ok) and (Bs =:= ok) ->
      {ok, {An, Bn}};
    (As =/= ok) ->
      {error, string:concat("problem with first dimension: ", An)};
    true ->
      {error, string:concat("problem with second dimension: ", Bn)}
  end.

calculate(rectangle, A, B) when (A>=0) and (B>=0) ->
  A * B;
calculate(triangle, A, B) when (A>=0) and (B>=0) ->
  A * B / 2;
calculate(ellipse, A, B) when (A>=0) and (B>=0) ->
  math:pi() * A * B;
calculate(_, _, _) -> io:format("Could not calculate!~n"), error.
