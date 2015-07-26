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

end
