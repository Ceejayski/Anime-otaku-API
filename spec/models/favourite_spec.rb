require 'rails_helper'

RSpec.describe Favourite, type: :model do
  it 'if factory is valid' do
    favourite = build(:favourite)
    expect(favourite).to be_valid
  end
  describe '#associations' do
    it { should belong_to :user}
    it { should belong_to :anime}
  end
end
