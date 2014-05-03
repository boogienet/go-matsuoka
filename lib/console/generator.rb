require 'libxml'

module GoMatsuoka
  module Console
    class Generator
      def self.timeline
        dir = Dir.mktmpdir
        document = LibXML::XML::Document.new
        document.root = LibXML::XML::Node.new('data')
        Project.all.each do |project|
          e = LibXML::XML::Node.new("event")
          e['start'] = project.start_date.to_s
          e['end'] = project.end_date.to_s
          e['title'] = project.name
          e['isDuration'] = true.to_s
          document.root << e
        end
        xml_data = "#{dir}#{File::SEPARATOR}data.xml"
        document.save(xml_data, :indent=>true, :encoding => LibXML::XML::Encoding::UTF_8)
        FileUtils.cp_r "#{File.dirname(__FILE__)}/timeline/timeline.html", dir
        puts dir
      end
    end
  end
end
