module Role
  extend ActiveSupport::Concern

  ROLES = { no_admin: 0, admin: 1 }

  def roles
    ROLES.keys
  end
  module_function :roles

  ROLES.each_pair do |role, value|
    define_method role do
      value
    end
    module_function role
  end

  included do
    before_create :set_default_role, :if => Proc.new{|u| u.role.nil?}

    ROLES.each_pair do |role, value|
      define_method "to_#{role}!" do
        self.update_attribute :role, value
      end
      
      define_method "is_#{role}?" do
        self.role == value
      end
      
      scope role.to_s.pluralize, -> { where(role: value) }
    end

    def set_default_role
      self.role = no_admin 
    end

    def role_name
      ROLES.detect {|k,v| v == role }.first.to_s
    end
  end
end
