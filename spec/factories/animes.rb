FactoryBot.define do
  factory :anime do
    sequence(:name) { |x| "MyString#{x}" }
    description { 'MyString' }
    sequence(:slug) { |x| "MyString#{x}" }
    rating { [1, 2, 3, 4, 5].sample }
    header_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png') }
    genre_list { 'north, east, south, west' }
    association :user
  end
end
