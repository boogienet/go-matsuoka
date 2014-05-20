require 'csv'
require 'yaml'
require 'active_support'

module GoMatsuoka
  module Console
    class Helper
      def self.import_actuals(params)

        # import everything wholesale
        data_file = params[:from]
        CSV.foreach(data_file, :headers=>true) do |entry|
          puts "#{entry["wbs"]} #{entry["key"]}"
          a = Actual.new(:wbs => entry['wbs'], :key => entry['key'], :hours => entry['hours'])
          a.save
        end

        # assess which entries come need to be associated
        Project.active.each do |project|
          a = Actual.where('wbs LIKE ?', "#{project.wbs}%")
          a.each do |actual|
            puts "#{actual.id} #{project}"
            actual.project = project
            actual.save
          end
        end

        Resource.active.each do |resource|
           a = Actual.where('key LIKE ?', "#{resource.key}%")
           a.each do |actual|
             puts "#{actual.id} #{resource}"
             actual.resource = resource
             actual.save
           end
        end
      end


      # allows you to run a command that looks like:
      # Helper.import :projects, :from=>"somefile.yml"
      def self.import(model_param, params)
        model = model_param.camelize.singularize
        file_name = params[:from]
        if File.extname(file_name).include?('csv')
          CSV.foreach(file_name, :headers=>true) do |line|
            obj = Object::const_get(model)
            line = line.to_hash
            associated = Hash.new
            ['resource_type', 'project_type', 'resource', 'project', 'service'].each do |assoc_obj|
              unless line[assoc_obj].nil? || line[assoc_obj].empty?
                assoc_class = Object::const_get(assoc_obj.camelize)
                associated[assoc_obj] = assoc_class.find_by_short_name(line[assoc_obj])
              end
            end
            line = line.merge(associated)
            puts line
            obj.find_or_create_by(line).save
          end
        end
      end

      # will always export to a CSV file
      # export "projects", :to=>"/Users/username/projects.csv"
      def self.export(model_param, params)
        model = model_param.camelize.singularize
        file_name = params[:to]
        obj = Object::const_get(model)
        csv_data = CSV.generate do |csv|
          csv << obj.column_names
          obj.all.each do |row|
            csv << row.attributes.values_at(*obj.column_names)
          end
        end
        f = File.new(file_name, 'w')
        f.write(csv_data)
      end

      # allows you to run a command that looks like:
      # Helper.add resource, to=>:project, :at=>80%
      def self.add(obj, params)
        dest = params[:to]
        source = obj
        puts "source: #{source.class} (#{source.id}) to destination: #{dest.class} (#{source.id})"
        source.planned_commitments.find_or_create_by(dest.class.to_s.downcase.to_sym => dest)
      end

      # Does a bulk import of data into the db
      # expects a directory of csvs named by model: resource_type, project_type, project, resource, planned_commitment
      # bulk_import :from=>"path" eg bulk_import :from=>"/Users/foo/"
      def self.bulk_import(params)
        data_file_dir = params[:from]
        import_order = ['resource_type', 'project_type', 'project', 'resource', 'planned_commitment', 'service', 'service_commitment']
        import_order.each do |model|
          data_file_full_path = data_file_dir + model.pluralize + '.csv'
          if File.exist?(data_file_full_path)
            import model.pluralize, :from => data_file_full_path
          end
        end
      end
    end
  end
end
