# == Schema Information
#
# Table name: day_hours
#
#  id           :integer          not null, primary key
#  day          :string
#  opening_time :string
#  closing_time :string
#  venue_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_day_hours_on_venue_id  (venue_id)
#

class DayHour < ActiveRecord::Base

  DAYNAMES = Date::DAYNAMES + [ 'Default', 'Weekdays', 'Weekends' ]

  belongs_to :venue

  validates :day, presence: true
  validates :venue, presence: true
  validates :opening_time, presence: true
  validates :closing_time, presence: true

  validate :time_format

  private

    def time_format
      times = [:opening_time, :closing_time]
      times.each do |time|
        parsed_time = Tod::TimeOfDay.try_parse self[time]
        next if parsed_time.present?
        errors.add(time, "needs proper formatting")
      end
    end

end
