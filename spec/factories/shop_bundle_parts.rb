# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop_bundle_part do
    id 1
    shop_bundle_id 1
    item_id 1
    amount 1
    positive ""
  end
end
