FactoryBot.define do
  factory :user do
    sequence(:email) { |x| "MyString#{x}" }
    password_digest { 'MyString' }
    sequence(:username) { |x| "MyString#{x}" }
    admin { false }
  end
end
