class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end
  
  def create?
    admin?
  end
  
  def edit?
    admin? || oneself?
  end
  
  def update?
    edit?
  end
  
  def show?
    edit?
  end
  
  def destroy?
    admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def oneself?
    user == record
  end
end
