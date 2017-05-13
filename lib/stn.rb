require "httparty"
require "mutations"
require "stn/configuration"
require "stn/client"
require "stn/purchase_order"

module Stn
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
