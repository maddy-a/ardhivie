class Ufile < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  belongs_to :location
end
