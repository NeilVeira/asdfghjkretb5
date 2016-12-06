FactoryGirl.define do
  factory :paypal_notification do
    params "MyText"
    cart_id 1
    status "MyString"
    transaction_id "MyString"
  end
end
