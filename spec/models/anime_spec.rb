require 'rails_helper'

RSpec.describe Anime, type: :model do
  it 'should have a valid fatory' do
    anime = build(:anime)
    expect(anime).to be_valid
  end
  describe '#validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :slug }
    it { should validate_presence_of :rating }
    it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  end
  context '#association' do
    it { should belong_to :user }
    it { should have_many :favourites }
  end
end
