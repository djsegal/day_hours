require 'test_helper'

class CheckAvailabilityTest < ActionDispatch::IntegrationTest
  test "the truth" do
    venue = venues(:normal_hours)
    venue.check_availability(Time.current)
    # binding.pry
  end
end
