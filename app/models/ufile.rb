class Ufile < ActiveRecord::Base
  attr_accessible :name, :data, :location_id
  has_attached_file :data, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :user
  belongs_to :location
  
   before_post_process :is_image?
  
   def is_image?
     !(data_content_type =~ /^image/).nil?
   end
  
end
