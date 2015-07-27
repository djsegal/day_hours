json.array!(@day_hours) do |day_hour|
  json.extract! day_hour, :id, :venue_id, :opening_time, :closing_time, :day
  json.url day_hour_url(day_hour, format: :json)
end
