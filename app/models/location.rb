class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude

  has_many :user
  has_many :tournament

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

end
