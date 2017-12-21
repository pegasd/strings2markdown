# frozen_string_literal: true

require 'erb'

module Strings2markdown
  # Render documentation hash to markdown
  class MarkdownRenderer
    def initialize(module_path)
      @module_resources = Strings2markdown::StringsParser.parse_module(module_path: module_path)
    end

    def render(path)
      content = File.read(File.expand_path(path))
      ERB.new(content, nil, '-').result(binding)
    end

    def render_puppet_classes
      md_classes = []
      classes    = @module_resources[:puppet_classes]
      classes.each do |puppet_class|
        @puppet_class   = puppet_class
        puppet_class_md = render('templates/resources/puppet_class.erb')
        md_classes.push(puppet_class_md)
      end
      md_classes.join("\n")
    end

    def render_defined_types
      md_defined_types = []
      defined_types    = @module_resources[:defined_types]
      defined_types.each do |defined_type|
        @defined_type   = defined_type
        defined_type_md = render('templates/resources/defined_type.erb')
        md_defined_types.push(defined_type_md)
      end
      md_defined_types.join("\n")
    end
  end
end
