FactoryBot.define do
  factory :favourite do
    association :user
    association :anime
  end
end
