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

  def update_role?
    admin? && !oneself?
  end
  
  def show?
    edit?
  end

  def show_role?
    admin?
  end
  
  def destroy?
    admin? && !oneself?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes
    if oneself?
      [:email, :password, :password_confirmation]
    elsif admin?
      [:email, :password, :password_confirmation, :role]
    end
  end

  def permitted_show_attributes
    if admin?
      [:email, :role_name]
    elsif oneself?
      [:email]
    end
  end

  private

  def oneself?
    user == record
  end
end
