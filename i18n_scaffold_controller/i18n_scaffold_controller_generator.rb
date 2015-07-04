require 'rails/generators/resource_helpers'

module Rails
  module Generators
    class MyScaffoldControllerGenerator < NamedBase # :nodoc:
      include ResourceHelpers

      check_class_collision suffix: "Controller"

      class_option :helper, type: :boolean
      class_option :orm, banner: "NAME", type: :string, required: true,
                         desc: "ORM to generate the controller for"
      class_option :api, type: :boolean,
                         desc: "Generates API controller"

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def update_i18n
        #append model_name.success.created,... to config/locale/zh-CN.yml(en.yml)
        puts "fuck u"
        inject_into_file 'config/locales/en.yml', after: "en:\n" do <<-'RUBY'
          puts "whatiaredoing"
        RUBY
        end
      end

      def create_controller_files
        puts "what are u doing"
        template_file = options.api? ? "api_controller.rb" : "controller.rb"
        template template_file, File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      end

      hook_for :template_engin1e, :test_framework, as: :scaffold

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper, as: :scaffold do |invoked|
        invoke invoked, [ controller_name ]
      end
    end
  end
end
