(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "homework1.sml";

val test1 = is_older((1,2,3),(1,2,3)) = false
val test12 = is_older((1,2,3),(1,2,4)) = true
val test13 = is_older((1,2,3),(1,3,3)) = true
val test14 = is_older((1,2,3),(2,2,3)) = true
val test15 = is_older((1,2,4),(1,2,3)) = false
val test16 = is_older((1,3,3),(1,2,3)) = false
val test17 = is_older((2,2,3),(1,2,3)) = false

val test2 = number_in_month([(2012,2,28),(2013,12,1),(2013,2,15)],2) = 2

val test3 = number_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test4 = dates_in_month([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test5 = dates_in_months([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string((2013, 6, 1)) = "June 1, 2013"

val test81 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3
val test82 = number_before_reaching_sum(11, [1,2,3,4,5]) = 4
val test83 = number_before_reaching_sum(7, [1,2,3,2,1]) = 3
val test84 = number_before_reaching_sum(8, [1,2,3,2,1]) = 3
val test85 = number_before_reaching_sum(9, [1,2,3,2,1]) = 4
val test86 = number_before_reaching_sum(10, [1,2,3,2,1]) = 5
val test87 = number_before_reaching_sum(1, [1,2,3,2,1]) = 0

val test91 = what_month(70) = 3
val test92 = what_month(90) = 3
val test93 = what_month(91) = 4
val test94 = what_month(120) = 4
val test95 = what_month(121) = 5

val test10 = month_range(31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
