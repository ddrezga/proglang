fun is_older (d1 : (int * int * int), d2 : (int * int * int)) =
    (#1 d1) < (#1 d2) andalso (#2 d1) < (#2 d2) andalso (#3 d1) < (#3 d2)

fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates 
    then 0
    else
	let 
	    val in_month = if (#2 (hd dates)) = month then 1 else 0
	in
	    number_in_month(tl dates, month) + in_month
	end

fun number_in_months (dates : (int * int * int) list, months : int list) =
    if null dates orelse null months 
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month (dates : ( int * int * int) list, month : int) =
    if null dates 
    then []
    else
	if (#2 (hd dates)) = month
	then
	    hd (dates) :: dates_in_month(tl dates, month)
	else
	    dates_in_month(tl dates, month)

fun dates_in_months (dates : ( int * int * int) list, months : int list) = 
    if null dates orelse null months 
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (xs : string list, nth : int) =
    if nth = 1 
    then hd xs 
    else get_nth(tl xs, nth - 1)

fun date_to_string (date : (int * int * int)) = 
    let
	val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, nums : int list) = 
    if null (tl nums) orelse (sum - hd nums - hd(tl nums) <= 0)
    then 0
    else number_before_reaching_sum(sum - hd nums, tl nums) + 1

fun what_month (day : int) = 
    let 
	val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	number_before_reaching_sum(day, days)
    end
