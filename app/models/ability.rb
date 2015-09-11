class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Game
    can :read, Tournament
    

    if user.is? :admin
      can :manage, :all
    end

  end
end
