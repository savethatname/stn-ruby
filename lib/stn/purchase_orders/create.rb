module Stn
  module PurchaseOrders
    class Create < Mutations::Command
      required do
        string :user_email
        string :stripe_token
        hash :profile do
          required do
            string :first_name
            string :last_name
            string :birthday, matches: /\A\d{2}\/\d{2}\/\d{4}\z/
            string :address1
            string :city
            string :state #, matches: /\A[A-Z]{2}\z/
            string :zip #, matches: /\A\d{5}\z/
            string :country
            string :phone
            string :email
            string :password
            string :title
          end
          optional do
            string :address2, empty: true, discard_empty: true
          end
        end
        array :purchases do
          hash do
            required do
              string :username
              array :services do
                hash do
                  required do
                    string :name
                  end
                end
              end
            end
          end
        end
      end

      def execute
        po = Stn::PurchaseOrder.new
        result = po.post("purchase_orders", {purchase_order: inputs})
        result
      end
    end
  end
end
