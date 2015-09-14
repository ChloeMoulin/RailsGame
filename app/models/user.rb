require 'digest'
class User < ActiveRecord::Base
	has_one :profile
	has_many :matches

	has_many :played_1, :foreign_key => "player_1_id", :class_name => "Match"
  has_many :played_2, :foreign_key => "player_2_id", :class_name => "Match"

	has_and_belongs_to_many :tournaments


  before_create :create_profile

	attr_accessible :email, :hashed_password, :role, :username, :password, :password_confirmation
  	attr_accessor :password, :password_confirmation
 	validates :email, :uniqueness => true, 
  					:length => {:within => 5..50},
  					:format => {:with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i}

  	validates :username, :uniqueness => true

  	validates :password, :length => {:within => 1..50},
  						:confirmation => true,
  						:presence => true,
  						:if => :password_required?

	before_save :encrypt_new_password

	def self.authenticate(email, password)
		user = find_by_email(email)
		return user if user && user.authenticated?(password)
	end

	def authenticated?(password)
		self.hashed_password == encrypt(password)
	end

	def is?( requested_role )
    	self.role == requested_role.to_s
  	end


	protected
		def encrypt_new_password
			return if password.blank?
			self.hashed_password = encrypt(password)
		end

		def password_required?
			hashed_password.blank? || password.present?
		end

		def encrypt(string)
			Digest::SHA1.hexdigest(string)
		end

	private
	def define_role
    self.build_profile
		self.role = "user"
	end

end
