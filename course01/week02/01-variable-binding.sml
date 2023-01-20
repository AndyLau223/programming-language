(*This is a comment. This is our first program*)

val x = 34; (*int*)
(* static environment: x: int *)
(* dynamic environment: x --> 34 *)
val y = 17;
(* static environment: x: int, y : int *)
(* dynamic environment: x --> 34, y --> 17 *)

val z = (x+y) + (y+2);
(* static environment: x:int, y:int, z:int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70 *)

val q = z + 1;
(* static environment: x:int, y:int, z:int, q:int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70, q --> 71 *)

val abs_of_z = if z < 0 then 0 - z else z;(* bool *) (* int *)
(* abs_of_z : int *)
(* dynamic environment: ...., abs_of_z --> 70 *)

val abs_of_z_simpler = abs z;
(* calling built-in function *)

Syntax: 
    if e1 then e2 else e3
    where if, then , and else are keywords and 
    e1, e2, and e3 are sub-exresspions

Type-checking:
    first e1 must have type bool 
    e2 and e3 can have any type(let's call it t ), but they must have the same type t.
    the type of the entire expression is also t 

Evaluation rules:
    firsrt evaluate e1 to a value call it v1 
    if it's true, evaluate e1 and that result is the whole expression's result.
    else, evaluate e3 and that result is the whole expression's result.
