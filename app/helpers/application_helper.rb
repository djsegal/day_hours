module ApplicationHelper

  def available?(venue, day, time)
    time_zone = venue.city.time_zone
    datetime = transform_to_datetime(day, time, time_zone)
    venue.check_availability(datetime)
  end

  extend Memoist
  def transform_to_datetime(day, time, time_zone)
    date_and_time  = Date.commercial(
      Date.today.year,
      Date.today.cwday.modulo(4)+Date.today.cweek,
      Date::DAYNAMES.index(day)
    ).to_s
    date_and_time += ' '
    date_and_time += Tod::TimeOfDay.try_parse(time).to_s

    ActiveSupport::TimeZone[time_zone].parse(date_and_time)
  end
  memoize :transform_to_datetime

end
