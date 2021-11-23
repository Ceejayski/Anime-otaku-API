require 'rails_helper'
RSpec.describe Api::V1::FavouritesController, type: :controller do
  let(:user) { create :user }
  let(:anime) { create :anime }
  let(:favourite) { create :favourite, user_id: user.id, anime_id: anime.id }
  describe '#index' do
    subject { get :index, params: { anime_id: anime.id } }

    it 'when success request sent' do
      favourite
      subject
      expect(response).to have_http_status(:ok)
      expect(json['data'][0]['attributes']['user_id']).to eql(user.id)
    end
  end
  describe '#create' do
    subject { post :create, params: { anime_id: anime.id } }

    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end
    context 'when authorized' do
      let(:user) { create :user }
      let(:anime) { create :anime }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end
      subject { post :create, params: { anime_id: anime.id } }
      it 'when success request sent' do
        subject
        expect(response).to have_http_status(:created)
        expect(json['data']['attributes']['anime_id']).to eql(anime.id)
      end
    end
  end
  describe '#destroy' do
    let(:user) { create :user }
    let(:anime) { create :anime }
    let(:favourite) { create :favourite }
    subject { delete :destroy, params: { id: favourite.id, anime_id: anime.id } }
    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end
    context 'when authorized' do
      let(:favourite2) { create :favourite, user_id: user.id, anime_id: anime.id }
      subject { delete :destroy, params: { id: favourite2.id, anime_id: anime.id } }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end
      it 'should have 204 status code' do
        subject
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
