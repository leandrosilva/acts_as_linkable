module CodeZone
  module Acts
    module Linkable
      def self.included(base)
        base.extend ClassMethods
      end
  
      module ClassMethods
        def acts_as_linkable
          include InstanceMethods
          extend SingletonMethods
        end
      end
  
      module InstanceMethods
        def link_to(link_spec = nil)
          link_spec.each_pair do |name, uri|
            raise ArgumentError.new('Argument must be :name => "uri".') unless name && uri

            links[name] = uri
          end
        end

        def links
          @links ||= {}
        end
        
        def is_linked_to?(name)
          links.include? name
        end
        
        def go_to_link!(name)
          puts "TODO should submit to #{name} (#{uri})."
        end
        
        def to_xml(args = {})
          xml = super(args)

          xml_doc = Nokogiri::XML(xml)

          links.each_pair do |name, uri|
            link_node = Nokogiri::XML::Node.new('atom:link', xml_doc)
            link_node['rel'] = name.to_s
            link_node['href'] = uri
            link_node['type'] = 'application/xml'

            xml_doc.root << link_node
          end

          xml = xml_doc.to_xml
        end
      end
      
      module SingletonMethods
        def from_xml(xml)
          payment = super(xml)

          xml_doc = Nokogiri::XML(xml)
          
          xml_doc.xpath('//link').each do |link_node|
            payment.link_to link_node['rel'].to_sym => link_node['href']
          end
          
          payment
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, CodeZone::Acts::Linkable)