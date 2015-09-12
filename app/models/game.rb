class Game < ActiveRecord::Base

  attr_accessible :company, :description, :grade, :name, :platform, :released_at, :cover_filename, :cover

  has_and_belongs_to_many :tournaments
  has_many :matches

  validates :name, :presence => true
  validates :description, :presence => true
  validates :company, :presence => true
  validates :grade, :presence => true 
  validates :platform, :presence => true
  validates :released_at, :presence => true

  mount_uploader :cover, CoverUploader 

end
  