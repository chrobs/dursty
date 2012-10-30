# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_part do
    id 1
    order_id 1
    item_id 1
    amount 1
    positive ""
  end
end
