(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option (_, []) = NONE
  | all_except_option (str: string, x::xs : string list) = 
    if x = str then SOME xs else
    case all_except_option(str, xs) of
        NONE => NONE
      | SOME lst => SOME (x::lst)

fun get_substitutions1 ([], str) = []
  | get_substitutions1 (x::xs, str) = 
    case all_except_option(str, x) of
        NONE => get_substitutions1(xs, str)
      | SOME res => res @ get_substitutions1(xs, str)

fun get_substitutions2 (strs, str) = 
    let 
	fun helper ([], _, res) = res
	  | helper(x::xs, str, res) = 
	    case all_except_option(str, x) of
		NONE => helper(xs, str, res)
	      | SOME l => helper(xs, str, res @ l) 
    in 
	helper(strs, str, [])
    end

fun similar_names (strs, {first=f,middle=m,last=l}) =
    let 
	fun helper ([]) = []
          | helper (x::xs) = {first=x,middle=m,last=l}::helper(xs)
    in
        {first=f,middle=m,last=l}::helper(get_substitutions2(strs, f))
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color (suit, rank) =
    case suit of
        Clubs => Black
      | Spades => Black
      | Hearts => Red
      | Diamonds => Red 

fun card_value (suit, rank) =
    case rank of
        Num num => num
      | Ace => 11
      | _ => 10 

fun remove_card ([], _, e): card list = raise e
  | remove_card (c::cs, card, e) = if c = card then cs else c::remove_card(cs, card, e)

fun all_same_color (cs: card list) =
    case cs of
        [] => true
      | c1::[] => true
      | c1::c2::cs => card_color(c1) = card_color(c2) andalso all_same_color(c2::cs)
                                         
fun sum_cards (cs: card list) = 
    let
        fun sum ([], acc: int) = acc
	  | sum (c::cs, acc)  = sum(cs, acc + card_value(c))
    in
        sum(cs, 0)
    end
                
fun score (cs: card list, goal: int) =
        let
                val sum = sum_cards(cs);
                val ps = if sum > goal then 3*(sum - goal) else (goal - sum)
        in
                if all_same_color(cs) then ps div 2 else ps
        end

fun officiate (cards, moves, goal) = 
    let 
	fun game_iter (_, [], held) = score(held, goal)
	  | game_iter (cards: card list, moves, held) = 
            case (cards, moves) of 
		([], Draw :: ms) =>  score(held, goal)
              | ([], Discard c :: ms) => raise IllegalMove 
              | (c :: cs, Draw :: ms) => if sum_cards(c::held) > goal then score(c::held, goal) else game_iter(cs, ms, c :: held)
              | (_, Discard c :: ms) => game_iter(remove_card(cards, c, IllegalMove), ms, held)
    in
        game_iter(cards, moves, [])
    end
