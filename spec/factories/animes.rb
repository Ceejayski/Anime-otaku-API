FactoryBot.define do
  factory :anime do
    sequence(:name) { |x| "MyString#{x}" }
    description { 'MyString' }
    sequence(:slug) { |x| "MyString#{x}" }
    header_image do
      [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.png'), 'spec/fixtures/test.png')]
    end
    association :user
  end
end
