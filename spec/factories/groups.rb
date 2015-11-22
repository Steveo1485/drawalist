FactoryGirl.define do
  factory :group do
    association :admin_user, factory: :user
    name {Faker::Company.name}
  end
end
