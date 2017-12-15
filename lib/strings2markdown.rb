# frozen_string_literal: true

require 'puppet-strings'
require 'puppet-strings/yard'
require 'puppet-strings/json'

# Convert puppet-strings output to Markdown format.
module Strings2markdown
  # Use puppet-strings to generate a hash.
  class StringsGenerator
    attr_reader :module_resources

    def initialize(module_path)
      @module_path            = module_path
      @strings_search_pattern = PuppetStrings::DEFAULT_SEARCH_PATTERNS.map { |path| "#{module_path}/#{path}" }

      PuppetStrings::Yard.setup!
      args = %w[doc -mmarkdown -n -q --no-progress --no-stats] + @strings_search_pattern
      YARD::CLI::Yardoc.run(*args)

      @module_resources = {
        puppet_classes:   YARD::Registry.all(:puppet_class).sort_by!(&:name).map!(&:to_hash),
        defined_types:    YARD::Registry.all(:puppet_defined_type).sort_by!(&:name).map!(&:to_hash),
        resource_types:   YARD::Registry.all(:puppet_type).sort_by!(&:name).map!(&:to_hash),
        providers:        YARD::Registry.all(:puppet_provider).sort_by!(&:name).map!(&:to_hash),
        puppet_functions: YARD::Registry.all(:puppet_function).sort_by!(&:name).map!(&:to_hash)
      }
    end
  end

  def self.parse_module(module_path: '.')
    # Always clear the YARD registry before each new run
    YARD::Registry.clear

    yard_hash_generator = Strings2markdown::StringsGenerator.new(module_path)
    yard_hash_generator.module_resources
  end
end
