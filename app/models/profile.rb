class Profile < ActiveRecord::Base

	belongs_to :user
  	attr_accessible :age, :country, :defeats, :ratio, :score, :user_id, :victories, :avatar
  	mount_uploader :avatar, CoverUploader 


end
