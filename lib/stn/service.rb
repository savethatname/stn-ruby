module Stn
  class Service < Client
    
    def self.available
      self.new.get("services")
    end 
  end
end
