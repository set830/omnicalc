class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    removeSpacesString = @text.delete " "
    @character_count_without_spaces = removeSpacesString.length


    @word_count = @text.split.size

    add=0

    @text.split.each do |x|
        if x == @special_word
            add = add+1
        end
    end

    @occurrences = add

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    numberofPayments = @years*12
    periodInterestRate = @apr/12
    payment = @principal*(periodInterestRate*(1 + periodInterestRate)**numberofPayments)/((1 + periodInterestRate)**numberofPayments - 1)
    @monthly_payment = payment

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.sort[0]

    @maximum = @numbers.sort[-1]

    @range = @maximum - @minimum

    midLength = @sorted_numbers.length/2

    @median = @sorted_numbers[midLength]

    @sum = @numbers.reduce :+

    @mean = @sum/@count

    y=0
    w=0

    @numbers.each do |num|
        y = @mean - num
        y = y*y
        w = w + y
    end


    @variance = w

    @standard_deviation = Math.sqrt(w)

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
