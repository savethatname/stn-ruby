module Stn
  module Cache
    def cache(key, options = {}, &block)
      return block.call unless cache_available?
      options[:expires_in] ||= 3600 #3600 seconds == 1.hour
      options.delete(:expires_in) if options[:expires_in].to_i < 1
      cache_service.fetch(key, options) { block.call }
    end

    def cache_key(*keys)
      keys.compact.join('/')
    end

    def delete(key)
      if cache_available?
        cache_service.delete(key)
      end
    end

    def find_keys(string)
      return [] unless cache_available?
      cache_service.data.keys(string)
    end

    def delete_keys(data)
      return if data.empty?
      return unless cache_available?
      cache_service.data.del(*data)
    end

    private

    def cache_available?
      return false unless cache_service.respond_to?(:fetch)
      cache_service.respond_to?(:data)
    end

    def cache_service
      Stn.configuration.cache_service
    end
  end
end
