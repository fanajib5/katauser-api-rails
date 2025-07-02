# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.persisted?
      # Logged in users can read and manage their own profile
      can :read, User, id: user.id
      can :update, User, id: user.id
      can :destroy, User, id: user.id

      # Add more abilities based on user roles if needed
      if user.admin?
        can :manage, :all
      end
    else
      # Guest users can only register
      can :create, User
    end
  end
end
