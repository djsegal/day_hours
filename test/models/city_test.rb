# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  time_zone  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CityTest < ActiveSupport::TestCase

  test "should correctly validate timezone" do
    city = cities(:london)
    assert city.valid?
    city.time_zone = nil
    assert_not city.valid?
  end

  test "should have correct timezones" do
    correct_timezones = {
      london: 'London',
      nyc: 'Eastern Time (US & Canada)',
      miami: 'Eastern Time (US & Canada)',
      singapore: 'Singapore',
    }
    correct_timezones.each do |key, value|
      assert cities(key).time_zone == value
    end
  end

end
