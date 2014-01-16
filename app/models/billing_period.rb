# TODO: This needs some specs bad..
class BillingPeriod
  attr_reader :weeks, :past_and_present_weeks, :target_date, :first_day, :last_day

  def initialize(date = Date.today)
    @target_date = date

    @weeks = []
    if(date.day <= 15)
      first_day = date.beginning_of_month
      last_day = first_day + 15.days

      next_day = date.beginning_of_month.beginning_of_week
      while(next_day < date || next_day.day <= 15)
        next_day = add_week(next_day)
      end
    else
      first_day = date.beginning_of_month + 15.days
      last_day = date.end_of_month

      next_day = first_day.beginning_of_week
      while(next_day.month == date.month)
        next_day = add_week(next_day)
      end
    end

    @past_and_present_weeks =
      @weeks.select { |week| week.first <= Date.today}

    @all_past_and_present_days =
      (first_day..last_day).select { |day| day <= Date.today }

    @first_day = first_day
    @last_day = last_day
  end

  def includes?(date)
    if(@target_date.day <= 15)
      date.month == @target_date.month && date.day <= 15
    else
      date.month == @target_date.month && date.day > 15
    end
  end

  def past_or_present_within_period?(date)
    includes?(date) && date <= Date.today
  end

  def past_and_present_days(week = nil)
    if(week)
      week.select{ |day| includes?(day) && day <= Date.today}
    else
      @all_past_and_present_days
    end
  end

private

   def add_week(week_start)
      week_end = week_start.end_of_week

      @weeks << (week_start..week_end)

      next_day = week_end + 1.day
   end
end
