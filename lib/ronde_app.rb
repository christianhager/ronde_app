require "ronde_app/version"
require "ronde_app/core"
require "ronde_app/instance"

module RondeApp
  class << self
    def app_class_from_name(name)
      Kernel.const_get("#{name}_app_instance".split("_").collect(&:capitalize).join)
    end
  end
end
