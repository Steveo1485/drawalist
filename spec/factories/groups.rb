FactoryGirl.define do
  factory :group do
    user
    name {Faker::Company.name}
  end
end
