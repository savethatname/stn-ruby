module Stn
  require "stn/purchase_orders/create"

  class PurchaseOrder < Client
    class InvalidPurchaseOrderError < Exception; end
    
    def self.create(params)
      outcome = PurchaseOrders::Create.run(params)
      if outcome.success?
        outcome.result
      else
        raise InvalidPurchaseOrderError, "PurchaseOrder is invalid. #{outcome.errors.message_list.join(", ")}"
      end
    end 
  end
end
