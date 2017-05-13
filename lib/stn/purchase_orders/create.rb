module Stn
  module PurchaseOrders
    class Create < Mutations::Command
      required do
        string :user_email
        hash :profile do
          string :first_name
          string :last_name
          string :birthday, matches: /\A\d{2}\/\d{2}\/\d{4}\z/
          string :address1
          string :address2
          string :city
          string :state #, matches: /\A[A-Z]{2}\z/
          string :zip #, matches: /\A\d{5}\z/
          string :country
          string :phone
          string :email
          string :password
          string :title
        end
        hash :purchases do

        end
      end

      def execute
        po = PurchaseOrder.new
        result = po.post("purchase_orders", {purchase_order: inputs})
        result
      end
    end
  end
end
