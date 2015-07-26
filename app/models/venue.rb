# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_venues_on_city_id  (city_id)
#

class Venue < ActiveRecord::Base

  belongs_to :city
  has_many :day_hours

  validates :city, presence: true
  validates :name, presence: true

  def check_availability(datetime)
    datetime = datetime.in_time_zone(city.time_zone)
    desired_time = datetime.strftime("%H:%M:%S")
    opening_times, closing_times = get_hours_for_date datetime
    purge_current_day_hours(opening_times, closing_times)
    return true if is_available? desired_time, opening_times, closing_times

    datetime -= 1.day
    desired_time = datetime.strftime("%H:%M:%S")
    opening_times, closing_times = get_hours_for_date(datetime)
    purge_previous_day_hours(opening_times, closing_times)
    return true if is_available? desired_time, opening_times, closing_times

    return false
  end

  def get_hours_for_date(datetime)
    day_of_week = datetime.strftime("%A").downcase
    is_weekend = datetime.saturday? || datetime.sunday?

    day_descriptions = [
      day_of_week,
      is_weekend ? 'weekend' : 'weekday',
      'default'
    ]
    opening_times = [] ; closing_times = []

    found_appropriate_description = false
    day_descriptions.each do |day_description|
      day_hours.each do |current_hours|
        next unless current_hours.day == day_description
        found_appropriate_description ||= true
        opening_times << current_hours.opening_time
        closing_times << current_hours.closing_time
      end
      break if found_appropriate_description
    end

    return opening_times, closing_times
  end

  private

    def is_available?(desired_time, opening_times, closing_times)
      friendly_time = Tod::TimeOfDay.try_parse(desired_time)
      opening_times.zip(closing_times).each do |opening_time, closing_time|
        next unless friendly_time >= Tod::TimeOfDay.try_parse(opening_time)
        next unless friendly_time <= Tod::TimeOfDay.try_parse(closing_time)
        return true
      end
      return false
    end

    def purge_current_day_hours(opening_times, closing_times)
      number_of_times = closing_times.count
      return if number_of_times.zero?
      (number_of_times-1..0).each do |i|
        friendly_opening_time = Tod::TimeOfDay.try_parse(opening_times[i])
        friendly_closing_time = Tod::TimeOfDay.try_parse(closing_times[i])
        next unless friendly_closing_time <= friendly_opening_time
        closing_times[i] = '23:59:59'
      end
    end

    def purge_previous_day_hours(opening_times, closing_times)
      number_of_times = opening_times.count
      return if number_of_times.zero?
      (number_of_times-1..0).each do |i|
        friendly_opening_time = Tod::TimeOfDay.try_parse(opening_times[i])
        friendly_closing_time = Tod::TimeOfDay.try_parse(closing_times[i])
        next unless friendly_closing_time <= friendly_opening_time
        opening_times[i] = '00:00:00'
      end
    end

end
