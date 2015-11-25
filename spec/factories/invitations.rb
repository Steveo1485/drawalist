FactoryGirl.define do
  factory :invitation do
    email {Faker::Internet.email}
    group
    is_member false
  end
end
