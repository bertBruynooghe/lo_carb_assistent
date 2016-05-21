module ApplicationHelper
  def render_date_time(date_time)
    render(partial: './date_time_text', locals: { date_time: date_time })
  end
end
