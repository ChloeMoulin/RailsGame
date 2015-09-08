class Game < ActiveRecord::Base
	attr_accessible :company, :description, :grade, :name, :platform, :released_at, :cover_filename, :cover
	attr_accessor :cover
	after_save :save_cover, if: :cover	

	validates :company, :presence => true
	validates :description, :presence => true
	validates :grade, :presence => true
	validates :name, :presence => true
	validates :platform, :presence => true
	validates :released_at, :presence => true

	def save_cover
		filename = cover.original_filename
		folder = "public/covers/"

		f = File.open File.join(folder,filename), "wb"
		f.write cover.read()
		f.close

		self.cover = nil
		update_attribute(:cover_filename, filename)
	end
end
