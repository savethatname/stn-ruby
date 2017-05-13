module Stn
  class Configuration
    OPTIONS = %i(
      api_key
    ).freeze

    OPTIONS.map(&method(:attr_accessor))
    attr_reader :api_version

    def initialize
      @api_version = "v1"
    end
  end
end
