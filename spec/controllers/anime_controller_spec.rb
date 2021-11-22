require 'rails_helper'
require 'json'

RSpec.describe Api::V1::AnimesController, type: :controller do
  let(:json_data) { JSON.parse(response.body) }
  describe '#index' do
    subject { get :index }

    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      create_list :anime, 4
      subject
      Anime.highest_rated.last do |anime, index|
        expect(json_data[index]['attributes']).to eq({
                                                       'name' => anime.title,
                                                       'description' => anime.description

                                                     })
      end
    end

    it 'should return animes in the proper order' do
      old_anime = create :anime, rating: 4.3
      newer_anime = create :anime, rating: 5.0
      subject
      expect(json_data['data'].first['id'].to_i).to eq(newer_anime.id)
      expect(json_data['data'].last['id'].to_i).to eq(old_anime.id)
    end
  end

  describe '#show' do
    let(:anime) { create :anime, rating: 5.0}
    subject { get :show, params: { id: anime.id } }

    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject
      expect(json_data['data']['attributes']['rating']).to eq( 5.0)
    end
  end
end