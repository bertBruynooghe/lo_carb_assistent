module ApplicationHelper
  def week_later_start_date_time(start_date_time)
    datetime = DateTime.iso8601(start_date_time)
    if (datetime + 21.days) > DateTime.now
      nil
    else
      DateTime.iso8601(start_date_time) + 7
    end
  end

  def week_earlier_start_date_time(week_start_date_time)
    if week_start_date_time
      DateTime.iso8601(week_start_date_time) - 7
    else
      Date.today - Date.today.cwday - 13
    end
  end
end
