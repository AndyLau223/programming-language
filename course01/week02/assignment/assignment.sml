(*
Programming Languages (Coursera / University of Washington)
Assignment 1
You will write 11 SML functions (and tests for them) related to calendar dates. In all problems, a “date”
is an SML value of type int*int*int, where the first part is the year, the second part is the month, and
the third part is the day. A “reasonable” date has a positive year, a month between 1 and 12, and a day no
greater than 31 (or less depending on the month). Your solutions need to work correctly only for reasonable
dates, but do not check for reasonable dates (that is a challenge problem) and many of your functions will
naturally work correctly for some/all non-reasonable dates. A “day of year” is a number from 1 to 365
where, for example, 33 represents February 2. (We ignore leap years except in one challenge problem.)
*)

(*
1. Write a function is_older that takes two dates and evaluates to true or false. It evaluates to true if
the first argument is a date that comes before the second argument. (If the two dates are the same,
the result is false.)
*)
fun is_older(date1: int * int *int, date2: int * int * int) =
    if #1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 = #3 date2
    then false 
    else if #1 date1 < #1 date2
    then true 
    else if #2 date1 < #2 date2
    then true 
    else if #3 date1 < #3 date2 
    then true 
    else 
        false


(*
2. Write a function number_in_month that takes a list of dates and a month (i.e., an int) and returns
how many dates in the list are in the given month.
*)

 fun number_in_month(xs: (int * int * int) list, month: int)= 
    if null xs 
    then 0
    else 
        if #2 (hd xs) = month 
        then 1 + number_in_month(tl xs, month)
        else 0 + number_in_month(tl xs, month)

(*
3. Write a function number_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns the number of dates in the list of dates that are in any of the months in the list of months.
Assume the list of months has no number repeated. Hint: Use your answer to the previous problem.
*)

fun number_in_months(xs: (int * int * int) list, months: int list) = 
    if null xs 
    then 0 
    else if null (tl months) 
    then number_in_month(xs, hd months)
    else number_in_months(xs, tl months) + number_in_month(xs, hd months)

(*
4. Write a function dates_in_month that takes a list of dates and a month (i.e., an int) and returns a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given.
*)

fun dates_in_month(xs: (int * int * int) list, month: int)  = 
    if null xs 
    then []
    else if #2 (hd xs) = month 
    then (hd xs) :: dates_in_month(tl xs, month)
    else dates_in_month(tl xs, month)

(*
5. Write a function dates_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns a list holding the dates from the argument list of dates that are in any of the months in
the list of months. Assume the list of months has no number repeated. Hint: Use your answer to the
previous problem and SML’s list-append operator (@).
*)
fun append(xs: (int * int * int) list, ys: (int * int * int) list) =
    if null xs
    then ys 
    else if null (tl xs)
    then (hd xs) :: ys
    else (hd xs) :: append(tl xs, ys) 

fun dates_in_months(xs: (int * int * int) list, months: int list)= 
    if null xs 
    then []
    else if null (tl months)
    then dates_in_month(xs,hd months)
    else append(dates_in_month(xs,hd months),dates_in_months(xs, tl months))
  

(*
6. Write a function get_nth that takes a list of strings and an int n and returns the nth element of the
list where the head of the list is 1st. Do not worry about the case where the list has too few elements:
your function may apply hd or tl to the empty list in this case, which is okay.
*)


fun get_nth(xs: string list, n: int) =
    if n = 1
    then hd xs
    else get_nth(tl xs, n-1)
(*
7. Write a function date_to_string that takes a date and returns a string of the form January 20, 2013
(for example). Use the operator ^ for concatenating strings and the library function Int.toString
for converting an int to a string. For producing the month part, do not use a bunch of conditionals.
Instead, use a list holding 12 strings and your answer to the previous problem. For consistency, put a
comma following the day and use capitalized English month names: January, February, March, April,
May, June, July, August, September, October, November, December.
*)
fun date_to_string(xs: int * int * int) = 
    get_nth(["January", "February", "March",
     "April", "May", "June", "July", "August",
      "September", "October", "November", "December"],#2 xs )
      ^ " "^Int.toString(#3 xs)^", "^ Int.toString(#1 xs)
(*
8. Write a function number_before_reaching_sum that takes an int called sum, which you can assume
is positive, and an int list, which you can assume contains all positive numbers, and returns an int.
You should return an int n such that the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more. Assume the entire list sums to more than the passed in
value; it is okay for an exception to occur if this is not the case.
*)
fun number_before_reaching_sum(sum : int, xs : int list) =
    let 
        fun helper(count: int, accumulate: int, xs: int list) = 
            if (accumulate + hd xs) >= sum 
            then count 
            else helper(count + 1, accumulate+hd xs, tl xs)
    in 
        helper(0,0,xs)
    end 
   



(*
9. Write a function what_month that takes a day of year (i.e., an int between 1 and 365) and returns
what month that day is in (1 for January, 2 for February, etc.). Use a list holding 12 integers and your
answer to the previous problem.
*)
fun what_month(dayOfYear: int) = 
     number_before_reaching_sum(dayOfYear, [31, 28, 31, 30, 31, 30, 31, 
				     31, 30, 31, 30, 31]) + 1;

(*
10. Write a function month_range that takes two days of the year day1 and day2 and returns an int list
[m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1, ..., and mn is the month
of day day2. Note the result will have length day2 - day1 + 1 or length 0 if day1>day2.
*)

fun month_range(day1: int, day2: int) =
    if day1 > day2 
    then []
    else what_month(day1)::month_range(day1+1, day2) 
(*
11. Write a function oldest that takes a list of dates and evaluates to an (int*int*int) option. It
evaluates to NONE if the list has no dates and SOME d if the date d is the oldest date in the list.
1
*)    
fun oldest(xs : (int * int * int) list ) =
    if null xs
    then NONE
    else
	let
        fun is_older(x : (int * int * int), y : (int * int * int)) =
        if #1 x < #1 y
        then true
        else 
        if #2 x < #2 y andalso #1 x = #1 y
        then true
        else
            if #3 x < #3 y andalso #1 x = #1 y andalso #2 x = #2 y
            then true
            else
            false

	    fun helper(xs : (int * int * int) list, date : (int * int * int)) =
		if null xs
		then true
		else 
		    if is_older(date, hd xs)
		    then helper(tl xs, date)
		    else false
            
	    fun helper_2(xs : (int * int * int) list) =
		if helper(tl xs, hd xs)
		then hd xs
		else helper_2(tl xs)
	in
	    SOME (helper_2(xs))
	end

