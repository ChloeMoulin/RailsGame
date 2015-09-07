class Game < ActiveRecord::Base
	attr_accessible :company, :description, :grade, :name, :platform, :released_at

	validates :company, :presence => true
	validates :description, :presence => true
	validates :grade, :presence => true
	validates :name, :presence => true
	validates :platform, :presence => true
	validates :released_at, :presence => true
end
