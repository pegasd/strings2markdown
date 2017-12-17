# frozen_string_literal: true

require 'puppet-strings'
require 'puppet-strings/yard'
require 'puppet-strings/json'

# Convert puppet-strings output to Markdown format.
module Strings2markdown
  # Use puppet-strings to generate a hash.
  class StringsParser
    attr_reader :module_resources

    def initialize(module_path)
      @module_path            = module_path
      @strings_search_pattern = PuppetStrings::DEFAULT_SEARCH_PATTERNS.map { |path| "#{module_path}/#{path}" }
      @module_parsed          = false
      @module_resources       = {}
    end

    def parse_module
      # Always clear the YARD registry before each new run
      YARD::Registry.clear

      PuppetStrings::Yard.setup!

      args = %w[doc -mmarkdown -n -q --no-progress --no-stats] + @strings_search_pattern
      YARD::CLI::Yardoc.run(*args)
      @module_resources = {
        puppet_classes:   parse_puppet_classes(YARD::Registry.all(:puppet_class).sort_by!(&:name).map!(&:to_hash)),
        defined_types:    YARD::Registry.all(:puppet_defined_type).sort_by!(&:name).map!(&:to_hash),
        resource_types:   YARD::Registry.all(:puppet_type).sort_by!(&:name).map!(&:to_hash),
        providers:        YARD::Registry.all(:puppet_provider).sort_by!(&:name).map!(&:to_hash),
        puppet_functions: YARD::Registry.all(:puppet_function).sort_by!(&:name).map!(&:to_hash),
      }

      @module_parsed = true
    end

    def parse_puppet_classes(yard_puppet_classes)
      puppet_classes = []
      yard_puppet_classes.each do |yard_puppet_class|
        docstring    = yard_puppet_class[:docstring]
        puppet_class = {
          name:        yard_puppet_class[:name].to_s,
          private:     check_if_private(docstring),
          description: docstring[:text],
          parameters:  parse_parameters(docstring, yard_puppet_class[:defaults]),
          source:      yard_puppet_class[:source],
        }

        puppet_classes.push(puppet_class)
      end
      puppet_classes
    end

    def check_if_private(docstring)
      api = docstring[:tags].select { |tag| tag[:tag_name].eql? 'api' }
      api.any? && api[0][:text].eql?('private')
    end

    def parse_parameters(docstring, defaults)
      yard_params = docstring[:tags].select { |tag| tag[:tag_name].eql? 'param' }
      params      = []
      yard_params.each do |yard_param|
        param               = {}
        param[:name]        = yard_param[:name]
        param[:type]        = yard_param[:types][0]
        param[:default]     = defaults[param[:name]] if defaults.is_a?(Hash) && defaults.key?(param[:name])
        param[:description] = yard_param[:text] if yard_param[:text] && !yard_param[:text].empty?

        params.push(param)
      end
      params
    end

    def self.parse_module(module_path: '.')
      yard_hash_generator = Strings2markdown::StringsParser.new(module_path)
      yard_hash_generator.parse_module
      yard_hash_generator.module_resources
    end
  end
end
