FactoryGirl.define do
  factory :list do
    user
    group
    paired_user_id {nil}
  end
end
