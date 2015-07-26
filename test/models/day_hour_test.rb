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

require 'test_helper'

class DayHourTest < ActiveSupport::TestCase

  test "should have valid fixtures" do
    DayHour.all.each do |day_hour|
      assert day_hour.valid?,
        "#{day_hour.day.pluralize.titleize} for " +
        "#{day_hour.venue.name} are bad."
    end
  end
end
