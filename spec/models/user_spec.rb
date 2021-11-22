require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should test if factory is valid' do
    user = build(:user)
    expect(user).to be_valid
  end
  context '#validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }
  end
  context '#associations' do
    it { is_expected.to have_secure_password }
    it { should have_many :animes }
    it { should have_many :favorite_anime }
  end
end
