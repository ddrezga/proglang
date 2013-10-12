fun is_older (d1 : (int * int * int), d2 : (int * int * int)) =
    #1 d1 < #1 d2 orelse (#1 d1 = #1 d2 andalso #2 d1 < #2 d2) orelse (#1 d1 = #1 d2 andalso #2 d1= #2 d2 andalso #3 d1 < #3 d2)

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
    if (null nums) orelse (sum - hd nums <= 0) then 0
    else number_before_reaching_sum(sum - hd nums, tl nums) + 1

fun what_month (day : int) = 
    let 
	val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	number_before_reaching_sum(day, days) + 1
    end

fun month_range (d1 : int, d2 : int) =
    if (d1 > d2) then []
    else what_month(d1)::month_range(d1 + 1, d2)

fun oldest (dates : (int * int * int) list) = 
    if null dates then NONE
    else
	let
	    fun oldest_nonempty(xs : (int * int * int) list) =
		if null (tl xs)
		then hd xs
		else
		    let val oldest = oldest_nonempty(tl xs)
		    in
			if is_older(oldest, hd xs) then oldest else hd xs
		    end
	in
	    SOME(oldest_nonempty(dates))
	end

	
fun filter_dups (xs : int list) = 
    if null xs then []
    else
	let
	    fun remove_elements (xs : int list, el : int) = 
		if null xs then []
		else if hd xs = el then remove_elements(tl xs, el)
		else (hd xs) :: remove_elements(tl xs, el)
	in 
	    (hd xs) :: filter_dups(remove_elements(tl xs, hd xs))
	end

fun number_in_months_challenge (dates : (int * int * int) list, months : int list) =
    if null dates orelse null months 
    then 0
    else
	let
	    val filtered_months = filter_dups(months)
	in
	    number_in_months(dates, filtered_months)
	end

fun dates_in_months_challenge (dates : ( int * int * int) list, months : int list) = 
    if null dates orelse null months 
    then []
    else
	let
	    val filtered_months = filter_dups(months)
	in
	    dates_in_months(dates, filtered_months)
	end

fun reasonable_date (date : (int * int * int)) =
    let
	val y = #1 date
	val m = #2 date
	val d = #3 date
	val feb = if (y mod 400) = 0  orelse ((y mod 4) = 0 andalso (y mod 100) > 0) then 29 else 28 
	fun get_nth (xs : int list, nth : int) =
	    if nth = 1 
	    then hd xs 
	    else get_nth(tl xs, nth - 1)
	val days = [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	(y > 0) andalso (m > 0) andalso (m <= 12) andalso (d > 0) andalso d <= get_nth(days, m)
    end
