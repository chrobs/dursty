# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artikel do
    name "MyString"
    kaufpreis 1
    verkaufspreis 1
    shop false
    kategorie 1
  end
end
