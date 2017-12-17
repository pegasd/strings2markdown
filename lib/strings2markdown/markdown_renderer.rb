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

    def render_classes
      md_classes = []
      classes    = @module_resources[:puppet_classes]
      classes.each do |puppet_class|
        @puppet_class = puppet_class
        class_md      = render('lib/templates/resources/puppet_class.erb')
        md_classes.push(class_md)
      end
      md_classes.join("\n")
    end
  end
end
