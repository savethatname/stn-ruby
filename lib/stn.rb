require "httparty"
require "mutations"
require "stn/configuration"
require "stn/cache"
require "stn/client"
require "stn/purchase_order"
require "stn/service"

module Stn
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
