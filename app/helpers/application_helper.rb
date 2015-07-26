module ApplicationHelper

  extend Memoist
  def transform_to_datetime(day, time, timezone)
    date = Date.commercial(
      Date.today.year,
      Date.today.cwday.modulo(4)+Date.today.cweek,
      Date::DAYNAMES.index(day)
    ).strftime("%m-%d-%Y")

    time = Tod::TimeOfDay.try_parse(time).to_s

    date_and_time = [date, time, timezone].join ' '
    datetime_format = '%m-%d-%Y %H:%M:%S %Z'
    DateTime.strptime(date_and_time,datetime_format)
  end
  memoize :transform_to_datetime

end
