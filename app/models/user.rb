require 'digest'
class User < ActiveRecord::Base
  has_one :profile
  has_many :matches


  has_many :played_1, :foreign_key => "player_1_id", :class_name => "Match"
  has_many :played_2, :foreign_key => "player_2_id", :class_name => "Match"

  has_and_belongs_to_many :tournaments
  after_create :define_role


  attr_accessible :email, :hashed_password, :role, :username, :password, :password_confirmation
  attr_accessor :password, :password_confirmation

  validates :email, :uniqueness => true, 
            :length => {:within => 5..30},
            :format => {:with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i},
            :presence => true

  validates :username, :uniqueness => true,
            :length => {:within => 2..15},
            :presence => true,
            :format => {:with => /^[a-zA-Z0-9_]{2,15}$/i}

	validates :password, :length => {:within => 10..50},
						:confirmation => true,
						:presence => true,
						:if => :password_required?


  before_save :encrypt_new_password


  def self.omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

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

    def calc_victories_for_a_tournament(tournament)
      matches = tournament.matches
      result = matches.where(:player_2_id => self.id).sum(:player_2_score) + matches.where(:player_1_id => self.id).sum(:player_1_score)
    end

    def self.build_ranking(tournament)
      users_ranking = Hash.new
      users = tournament.users
      users.each do |user|
        users_ranking[user] = user.calc_victories_for_a_tournament(tournament)
      end
      users_ranking.sort_by{ |a,b| b}.reverse

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
