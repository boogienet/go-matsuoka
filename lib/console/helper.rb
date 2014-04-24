require 'yaml'
require 'active_support'

module GoMatsuoka
  module Console
    class Helper
      # allows you to run a command that looks like:
      # Helper.import :projects, :from=>"somefile.yml"
      def self.import (model, params)
        model = model.singularize
        file_name = params[:from]
        data = YAML.load_file(file_name)
        data[model].each do |m|
          obj = Object::const_get(model.capitalize).new(m)
          obj.save
        end
      end

      # allows you to run a command that looks like:
      # Helper.add resource, to=>:project, :at=>80%
      def self.add (obj, params)
      end
    end
  end
end
