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
            string :title

            # Putting these back in until we can figure out why it fails without them
            string :email
            string :password
          end
          optional do
            string :address2, empty: true, discard_empty: true
          end
        end
        array :purchases do
          hash do
            required do
              string :username, min_length: 3, max_length: 30, strip: true, matches: /^\w+$/
              array :services, min_length: 2 do
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
        result = po.post("purchase_orders", {purchase_order: encoded_params})
        result
      end

      # force encodes all data from ISO to UTF8
      private def encoded_params
        inputs[:profile].each { |k,v| inputs[:profile][k] = v.force_encoding("ISO-8859-1").encode("UTF-8") if v.is_a?(String) }
        inputs
      end
    end
  end
end
