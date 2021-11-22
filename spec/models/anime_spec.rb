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
    it { should validate_presence_of :header_image }
  end
  context '#association' do
    it { should belong_to :user }
  end
end
