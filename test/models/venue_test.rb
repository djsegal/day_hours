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

require 'test_helper'

class VenueTest < ActiveSupport::TestCase

  test "should correctly validate name" do
    venue = venues(:normal_hours)
    assert venue.valid?
    venue.name = nil
    assert_not venue.valid?
  end

  test "should correctly validate city relation" do
    venue = venues(:normal_hours)
    assert venue.valid?
    venue.city = nil
    assert_not venue.valid?
  end

end
