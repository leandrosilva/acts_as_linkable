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
        def link_to(link = nil)
          link.each_pair do |name, uri|
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
        
        def link_for(name)
          links[name]
        end
        
        def to_xml(args = {})
          xml = super(args)

          doc = Nokogiri::XML(xml)

          links.each_pair do |name, uri|
            node = Nokogiri::XML::Node.new('atom:link', doc)
            node['rel'] = name.to_s
            node['href'] = uri
            node['type'] = 'application/xml'
            node['xmlns:atom'] = 'http://www.w3.org/2005/Atom'

            doc.root << node
          end

          xml = doc.to_xml
        end
      end
      
      module SingletonMethods
        def from_xml(xml)
          links = {}
          
          doc = Nokogiri::XML(xml)
          doc.xpath('//atom:link', 'atom' => 'http://www.w3.org/2005/Atom').each do |node|
            links[node['rel'].to_sym] = node['href']
            node.remove
          end
          
          payment = super(doc.to_xml)
          payment.links.merge! links
          payment
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, CodeZone::Acts::Linkable)