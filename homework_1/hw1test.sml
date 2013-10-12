(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "homework1.sml";

val test1 = is_older((1,2,3),(1,2,3)) = false
val test1_2 = is_older((1,2,3),(1,2,4)) = true
val test1_3 = is_older((1,2,3),(1,3,3)) = true
val test1_4 = is_older((1,2,3),(2,2,3)) = true
val test1_5 = is_older((1,2,4),(1,2,3)) = false
val test1_6 = is_older((1,3,3),(1,2,3)) = false
val test1_7 = is_older((2,2,3),(1,2,3)) = false

val test2 = number_in_month([(2012,2,28),(2013,12,1),(2013,2,15)],2) = 2

val test3 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test4 = dates_in_month([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test5 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string((2013, 6, 1)) = "June 1, 2013"

val test8_1 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3
val test8_2 = number_before_reaching_sum(11, [1,2,3,4,5]) = 4
val test8_3 = number_before_reaching_sum(7, [1,2,3,2,1]) = 3
val test8_4 = number_before_reaching_sum(8, [1,2,3,2,1]) = 3
val test8_5 = number_before_reaching_sum(9, [1,2,3,2,1]) = 4
val test8_6 = number_before_reaching_sum(10, [1,2,3,2,1]) = 5
val test8_7 = number_before_reaching_sum(1, [1,2,3,2,1]) = 0

val test9_1 = what_month(70) = 3
val test9_2 = what_month(90) = 3
val test9_3 = what_month(91) = 4
val test9_4 = what_month(120) = 4
val test9_5 = what_month(121) = 5

val test10 = month_range(31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

val test12 = filter_dups([1,1,2,3,4,4,5,6,7,7,7]) = [1,2,3,4,5,6,7]

val test13 = number_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,3,4]) = 3

val test14 = dates_in_months_challenge([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test15 = reasonable_date((2012,1,1)) = true
val test16 = reasonable_date((2012,4,32)) = false
val test17 = reasonable_date((2012,2,29)) = true
val test18 = reasonable_date((2013,2,29)) = false
val test19 = reasonable_date((2008,2,29)) = true
val test20 = reasonable_date((2000,2,29)) = true
val test21 = reasonable_date((1800,2,29)) = false
val test22 = reasonable_date((1900,2,29)) = false
