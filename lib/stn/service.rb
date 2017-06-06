module Stn
  class Service < Client
    
    def self.available(params = {})
      cache(cache_key("services", "all", *params.values)) do
        self.new.get("services", params)
      end
    end 
  end
end
