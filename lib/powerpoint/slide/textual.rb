require 'zip/filesystem'
require 'fileutils'

module Powerpoint
  module Slide
    class Powerpoint::Slide::Textual
      def initialize extract_path, title, content, slide_number
        template_path = "#{TEMPLATE_PATH}/ppt/slides/slide2.xml"
        xml = File.read template_path

        title_xml = '<a:p><a:r><a:rPr lang="en-US" dirty="0" smtClean="0"/><a:t>'+ title.to_s + '</a:t></a:r><a:endParaRPr lang="en-US" dirty="0"/></a:p>'
        xml.gsub!('SLIDE_TITLE_PACEHOLDER', title_xml)

        content_xml = ''
        content.each do |i|
          content_xml += '<a:p><a:r><a:rPr lang="en-US" dirty="0" smtClean="0"/><a:t>' + i.to_s + '</a:t></a:r></a:p>'
        end

        xml.gsub!('CONTENT_PACEHOLDER', content_xml)

        slide_path = "#{extract_path}/ppt/slides/slide#{slide_number}.xml"
        File.open(slide_path, 'w'){ |f| f << xml }
      end
    end
  end
end