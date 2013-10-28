(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3provided.sml";

val test1_1 = only_capitals ["Aaa","Bbb","Cc"] = ["Aaa","Bbb","Cc"]
val test1_2 = only_capitals ["Aa","B","cb"] = ["Aa","B"]
val test1_3 = only_capitals ["aa","bb","cc"] = []

val test2 = longest_string1 ["A","bc","Cd"] = "bc"

val test3 = longest_string2 ["A","bc","Cd"] = "Cd"

val test4a= longest_string3 ["A","bc","C"] = "bc"

val test4b= longest_string4 ["A","B","C"] = "C"

val test5 = longest_capitalized ["A","bc","Caa"] = "Caa";

val test6 = rev_string "abc" = "cba";

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test8_1 = all_answers (fn x => if x>1 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]

val test9a = count_wildcards Wildcard = 1

val test9a_1 = count_wildcards (TupleP [Wildcard, Wildcard]) = 2

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1;

val test10 = check_pat (Variable("x")) = true

val test10_1 = check_pat (TupleP [Variable("x"), Variable("y")]) = true

val test11 = match (Const(1), UnitP) = NONE

val test11_1 = match(Const 1, ConstP 1) = SOME[]

val test11_2 = match(Unit, Variable "test") = SOME[("test", Unit)]

val test12 = first_match Unit [UnitP] = SOME []

val test12_1= first_match (Const 1) [ConstP 1] = SOME []
