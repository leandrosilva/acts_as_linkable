module CodeZone
  module Acts
    module Linkable
      def self.included(base)
        base.extend ClassMethods
      end
  
      module ClassMethods
        def acts_as_linkable
          include InstanceMethods
        end
      end
  
      module InstanceMethods
        def link_to(link_spec = nil)
          link_spec.each_pair do |name, uri|
            raise ArgumentError.new('Argument must be :name => "uri".') unless name && uri
            
            define_link_methods(name, uri)
          end
        end
        
        def is_linked_to?(link_name)
          respond_to? "#{link_name}_link"
        end
        
        def go_to_link!(link_name)
          puts "TODO should submit to #{name} (#{uri})."
        end

        private
  
          def define_link_methods(name, uri)
            class_eval do
              send(:define_method, "#{name}_link") do
                uri
              end
            end
          end
      end
    end
  end
end

ActiveRecord::Base.send(:include, CodeZone::Acts::Linkable)