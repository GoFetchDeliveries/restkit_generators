require 'ostruct'

module RestKit
  class Config
    def initialize(config_file_path)
      @options = parse_config(config_file_path)
    end

    def models
      @options.fetch(:models, {})
    end

    def excluded_models
      @options.fetch(:exclude_models, {})
    end

    # @param model_name [String] The model's name
    # @return [Array<String>] Columns to exclude for this model. Returns an empty array if none.
    def excluded_columns_for_model(model_name)
      models.fetch(model_name, {}).fetch(:exclude, [])
    end

    # @param model_name [String] The model's name
    # @return [Array<Object>] Columns to add for this model (iOS config file should define name and type).
    # Returns an empty array if none.
    def additional_columns_for_model(model_name)
      models.fetch(model_name, {}).fetch(:additions, {}).map { |addition|
        OpenStruct.new(
          name: addition[:name],
          type: addition[:type]
        )
      }
    end

    private

    # @return [Hash] Config loaded from YAML config file.
    def parse_config(config_file_path)
      YAML.load(File.open(config_file_path)).with_indifferent_access
    rescue => e
      puts "No .ios_sdk_config.yml file found!"
      {}
    end

  end
end