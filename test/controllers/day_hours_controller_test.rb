require 'test_helper'

class DayHoursControllerTest < ActionController::TestCase
  setup do
    @day_hour = day_hours(:normal_weekday)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_hour" do
    assert_difference('DayHour.count') do
      post :create, day_hour: { closing_time: @day_hour.closing_time, day: @day_hour.day, opening_time: @day_hour.opening_time, venue_id: @day_hour.venue_id }
    end

    assert_redirected_to day_hour_path(assigns(:day_hour))
  end

  test "should show day_hour" do
    get :show, id: @day_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_hour
    assert_response :success
  end

  test "should update day_hour" do
    patch :update, id: @day_hour, day_hour: { closing_time: @day_hour.closing_time, day: @day_hour.day, opening_time: @day_hour.opening_time, venue_id: @day_hour.venue_id }
    assert_redirected_to day_hour_path(assigns(:day_hour))
  end

  test "should destroy day_hour" do
    assert_difference('DayHour.count', -1) do
      delete :destroy, id: @day_hour
    end

    assert_redirected_to day_hours_path
  end
end
