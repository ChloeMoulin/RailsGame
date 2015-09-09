class Tournament < ActiveRecord::Base
  has_and_belongs_to_many :games
  has_and_belongs_to_many :users

  attr_accessible :place, :date, :max_player, :name, :description, :game_ids, :user_ids

  validates :name, :presence => true
  validates :description, :presence => true
  validates :place, :presence => true
  validates :date, :presence => true
  validates :max_player, :presence => true
  validates_presence_of :games
end
