class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :user_id
  belongs_to :user
  has_many :ufiles
end
