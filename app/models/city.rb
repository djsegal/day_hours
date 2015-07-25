# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  time_zone  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ActiveRecord::Base

  validates :time_zone, presence: true

end
