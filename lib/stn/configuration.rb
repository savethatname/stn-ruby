module Stn
  class Configuration
    OPTIONS = %i(
      api_key
      cache_service
    ).freeze

    OPTIONS.map(&method(:attr_accessor))
    attr_reader :api_version

    def initialize
      @api_version = "v1"
      @cache_service = defined?(Rails) ? Rails.cache : nil
    end
  end
end
