# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_part_item do
    order_part_id ""
    item_id ""
    amount ""
    price ""
    name "MyString"
  end
end
