require 'csv'
require 'yaml'
require 'active_support'

module GoMatsuoka
  module Console
    class Helper
      # allows you to run a command that looks like:
      # Helper.import :projects, :from=>"somefile.yml"
      def self.import (model_param, params)
        model = model_param.camelize.singularize
        file_name = params[:from]
        if File.extname(file_name).include?('yml')
          data = YAML.load_file(file_name)
          data[model].each do |m|
            obj = Object::const_get(model).find_or_create_by(m)
            obj.save
          end
        end
        if File.extname(file_name).include?('csv')
          CSV.foreach(file_name, :headers=>true) do |line|
            obj = Object::const_get(model).find_or_create_by(line.to_hash)
            obj.save
          end
        end
      end

      def self.export (model, params)
        model = model.camelize.singularize
        file_name = params[:to]
        data = Hash.new
        data[model] = []
        Object::const_get(model.capitalize).all.each do |d|
          data[model].push(d.attributes)
        end

        File.open(file_name, 'w') do |f|
          YAML::dump(data,f)
        end
      end

      # allows you to run a command that looks like:
      # Helper.add resource, to=>:project, :at=>80%
      def self.add (obj, params)
        dest = params[:to]
        source = obj
        puts "source: #{source.class} (#{source.id}) to destination: #{dest.class} (#{source.id})"
        source.planned_commitments.find_or_create_by(dest.class.to_s.downcase.to_sym => dest)
      end
    end
  end
end
