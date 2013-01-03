require 'hanber/version'
require 'generators/hanber/generator_helpers'
require 'generators/hanber/model_generator'
require 'generators/hanber/route_handler_generator'
module Hanber
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      include Hanber::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)
      
      argument :attributes, :type => :array, :default => [], :banner => "field[:type] field[:type] ..."
      
      desc "Scaffold a restful resource for ember similarly to the rails scaffold generator."

      def create_model
        generate("hanber:model", attributes)
        #template 'model.js', File.join('app/assets/javascripts/models', class_path, "#{file_name}.js")
      end
      def create_resourceful_route

        insert_into_file "app/assets/javascripts/router.js", after: ".map(function(match) {\n" do
          %Q(  
            match("/#{file_name.pluralize}").to("#{file_name.pluralize}", function(match) {
              match("/").to("#{file_name.pluralize}Index");
              match("/new").to("#{file_name}New");
              match("/:#{file_name.underscore}_id").to("#{file_name}", function(match) {
                match('/').to("#{file_name}Show")
                match("/content").to("#{file_name}Edit");
              });
            });
          )
        end
      end
      def create_route_handlers
        resource_hash = {show: "#{file_name}Show", index: "#{file_name.pluralize}Index", new: "#{file_name}New", edit: "#{file_name}Edit"}
        resource_hash.each do |restful_action, restful_name|
          template 'route_handler.js', File.join("app/assets/javascripts/route_handlers/#{file_name}_routes", class_path, "#{restful_name.underscore}.js")
        end
      end
    end
  end
end
