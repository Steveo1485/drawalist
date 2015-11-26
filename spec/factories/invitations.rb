FactoryGirl.define do
  factory :invitation do
    email {Faker::Internet.email}
    group
  end
end
