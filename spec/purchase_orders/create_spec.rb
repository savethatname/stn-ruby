require "spec_helper"

RSpec.describe Stn::PurchaseOrders::Create do
  
  context "validations" do
    let(:inputs) do
      {
        user_email: "test@test.com",
        stripe_token: "cus_239cvansfAEHRo3r",
        profile: {
          first_name: "Test",
          last_name: "Tester",
          birthday: "01/01/1980",
          address1: "123 street",
          address2: "",
          city: "Las Vegas",
          state: "NV",
          zip: "89109",
          country: "US",
          phone: "702-123-1234",
          email: "test@test.com",
          password: "passwordsecret",
          title: "Mr"
        },
        purchases: [
          {username: "testermctest", services: [
            {name: "facebook"},
            {name: "twitter"}
          ]}
        ]
      }
    end
    before do
      allow_any_instance_of(Stn::PurchaseOrder).to receive("post").with("purchase_orders", {purchase_order: inputs}).and_return(true)
    end
    it "validates inputs" do
      outcome = Stn::PurchaseOrders::Create.run(inputs)
      expect(outcome).to be_success
    end
  end
end
