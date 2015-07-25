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

  has_many :venues

  validates :time_zone, presence: true

end
