class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Game
    can :read, Tournament
    can :read, Match
    can :read, Profile
    can :create, User



    if user.is? :user
      can :update, Profile do |p|
        p.user == user
      end

      can :update, User do |u|
        u == user
      end

      can :register, Tournament
      can :register_match, Tournament


    end

    if user.is? :admin
      can :manage, :all
    end

  end
end
