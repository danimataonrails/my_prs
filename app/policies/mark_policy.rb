class MarkPolicy < ApplicationPolicy
  def index?
    true
  end
  
  def create?
    true
  end
  
  def edit?
    record.user == user
  end
  
  def update?
    edit?
  end
  
  def show?
    edit?
  end
  
  def destroy?
    edit?
  end

  class Scope < Scope
    def resolve
      if admin?
        scope
      else
        scope.by_user(user)
      end
    end
  end
end
