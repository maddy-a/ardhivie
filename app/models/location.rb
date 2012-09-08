class Location < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :user_id, :address, :title
  belongs_to :user
  has_many :ufiles
  
  validates :latitude, :longitude, :title, :presence => true  
  validates :address, :uniqueness => true
  validates :latitude, :uniqueness =>{ :scope=> :longitude}
end
