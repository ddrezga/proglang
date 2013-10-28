(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals xs = List.filter (fn x => Char.isUpper(String.sub(x, 0))) xs

fun longest_string1 ss = List.foldl (fn (a, b) => if String.size a > String.size b then a else b) "" ss

fun longest_string2 ss = List.foldl (fn (a, b) => if String.size a >= String.size b then a else b) "" ss

fun longest_string_helper f = List.foldl (fn (a, b) => if f (String.size a, String.size b) then a else b) ""

val longest_string3 = longest_string_helper(fn (a, b) => a > b)

val longest_string4 = longest_string_helper(fn (a, b) => a >= b)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o List.rev o String.explode

fun first_answer f [ ] = raise NoAnswer
  | first_answer f (x :: xs) =
    case f x of
        NONE   => first_answer f xs
      | SOME y => y

fun all_answers f xs =
    let
	fun helper ([ ], acc) = SOME acc
	  | helper (x :: xs, acc) =
            case f x of
		NONE   => NONE
              | SOME y => helper(xs, acc @ y)
    in
	helper(xs, [ ])
    end
val count_wildcards = g (fn x => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn x => 1) String.size

fun count_some_var (s, p) = g (fn x => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p =
    let
	fun varstrs (Variable x) = [x]
	  | varstrs (TupleP ts) = List.foldl (fn (t, acc) => acc @ varstrs(t)) [ ] ts
	  | varstrs _ = []
	fun nodups [] = true
	  | nodups (x :: xs) = not (List.exists (fn y => x = y) xs) andalso nodups xs
    in
	nodups(varstrs(p))
    end
	
	
fun match (_, Wildcard) = SOME [ ]
  | match (v, Variable s) = SOME [(s, v)]
  | match (Unit, UnitP) = SOME [ ]
  | match (Const a, ConstP b) = if a =b then SOME [ ] else NONE
  | match (Tuple ps, TupleP qs) = if length ps = length qs 
				  then all_answers match (ListPair.zip(ps, qs))
				  else NONE
  | match (Constructor (s,v), ConstructorP (t, w)) = if s = t then match (v, w) else NONE
  | match _ = NONE

fun first_match v ps = SOME (first_answer (fn x => match (v, x)) ps) handle NoAnswer => NONE
