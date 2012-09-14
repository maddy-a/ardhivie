class Ufile < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :name, :data, :location_id
  has_attached_file :data, 
    :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny => "10x10>" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :s3_permissions => :private,
    :path => ":rails_env/:class/:attachment/:style/:id/:filename"
  belongs_to :user
  belongs_to :location
  
  # validates :name, :location_id, :presence => true
  before_post_process :image?

  def image?
    !(data_content_type =~ /^image/).nil?
  end

  def to_jq_upload
    {
      "name" => data_file_name,
      "size" => data.size,
      "url" => download_ufile_path(id) ,
      "thumbnail_url" => image? ? data.url(:tiny) : nil,
      "delete_url" => api_ufile_path(self),
      "delete_type" => "DELETE"
    }
  end
end
