FactoryGirl.define do
  factory :list_item do
    list
    name {Faker::Commerce.product_name}
    url {Faker::Internet.url}
  end
end
