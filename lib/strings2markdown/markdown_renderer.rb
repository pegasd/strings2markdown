# frozen_string_literal: true

module Strings2markdown
  # Render documentation hash to markdown
  class MarkdownRenderer
    def initialize(module_path)
      @module_resources = Strings2markdown::StringsParser.parse_module(module_path: module_path)
    end
  end
end
