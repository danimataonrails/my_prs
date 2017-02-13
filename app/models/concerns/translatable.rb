module Translatable
  extend ActiveSupport::Concern

  included do
  end 
  
  class_methods do
    def translate(*list)
      translated_fields = Array(list)
      define_get_methods(translated_fields)
      define_set_methods(translated_fields)
      define_check_methods(translated_fields)
    end

    def define_get_methods(list)
      list.each do |item|
        define_method("get_#{item}") do |locale|
          self["#{item}_translations"] ? JSON.parse(self["#{item}_translations"])[locale.to_s] : ''
        end
        
        define_method(item) do           
          send("get_#{item}", I18n.locale)                                 
        end
        
        I18n.available_locales.each do |locale|
          define_method("#{item}_#{locale}") do           
            send("get_#{item}", locale)                                 
          end
        end
      end
    end

    def define_set_methods(list)
      list.each do |item|
        define_method("set_#{item}") do |str, locale|
          h_title = self["#{item}_translations"] ? JSON.parse(self["#{item}_translations"]) : {}
          h_title[locale.to_s] = str
          self["#{item}_translations"] = h_title.to_json
        end
        
        define_method("#{item}=") do |str|    
          send("set_#{item}", str, I18n.locale)                                 
        end
        
        I18n.available_locales.each do |locale|
          define_method("#{item}_#{locale}=") do |str|        
            send("set_#{item}", str, locale)                                 
          end
        end
      end
    end

    def define_check_methods(list)
      list.each do |item|
        before_validation "check_#{item}_translations_is_initialized"
        define_method("check_#{item}_translations_is_initialized") do
          self["#{item}_translations"] = '{}' if self["#{item}_translations"].blank?
        end
      end
    end
  end
end
