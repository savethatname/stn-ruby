module Stn
  class Configuration
    OPTIONS = %i(
      api_key
    ).freeze

    OPTIONS.map(&method(:attr_accessor))
    attr_reader :version
    
    def initialize
      @version = "v1"
    end
  end
end
