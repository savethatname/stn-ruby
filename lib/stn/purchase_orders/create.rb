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
            string :birthday, matches: /\A(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])\/(19|20)\d\d\z/
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

      optional do
        string :coupon_code, empty: true, discard_empty: true
      end

      def execute
        po = Stn::PurchaseOrder.new
        result = po.post("purchase_orders", {purchase_order: inputs})
        result
      end
    end
  end
end
