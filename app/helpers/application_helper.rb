module ApplicationHelper
  def render_datetime(datetime)
    render(partial: './datetime_text', locals: { datetime: datetime })
  end
end
