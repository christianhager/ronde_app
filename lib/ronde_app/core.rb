module RondeApp
  module Core
    extend ActiveSupport::Concern
    
    included do
      class_attribute :app_settings
      self.app_settings = {}
      set_callback :create, :after, :install_apps

      delegate "app_contexts", :to => 'self.class'
    end
    
    
    module ClassMethods
      def installable_app(*args)
          app_options = args.extract_options!
          app_name = args.shift.to_sym
          
          #
          # set defaults
          #
          options = app_options.reverse_merge!(
            :install_on_creation => false,
            :app_name => app_name
          )
          
          #
          # register/update settings
          #
          class_options = app_settings || {}
          class_options[app_name] = options
          self.app_settings = class_options
          
          #
          # app name is transferred and turn into has_one :app_name, :class_name => AppNameInstance
          # e.g. :crm becomes CrmAppInstance
          
          app_class = RondeApp.app_class_from_name(app_name)
          
          belongs_to app_name, :class_name => "#{app_class}"

          
          # instance methods
          class_eval <<-END
            #{app_class.delegations}
            
            def #{app_name}_app
              self.#{app_name}
            end
          END
          
      end
      
      def app_contexts
        self.app_settings.keys
      end
    end
    
    module InstanceMethods
      def apps
        result = []
        app_contexts.each do |context|
          result << self.send(context)
        end
        result
      end
      
    end
    
    
    private
    
    def install_apps
      app_contexts.each do |context|
        if app_settings[context][:install_on_creation]
          self.send("#{context}=", RondeApp.app_class_from_name(app_settings[context][:app_name]).create)
          self.save
        end
      end
    end
  end
end