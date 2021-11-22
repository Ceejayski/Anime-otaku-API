require 'rails_helper'
RSpec.describe Api::V1::FavouritesController, type: :controller do
  describe '#index' do
    subject { get :index }
    
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
      subject { get :index }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it 'when success request sent' do
        user.favourites.create(anime_id: anime.id)
        subject
        expect(response).to have_http_status(:ok)
        expect(json['data'][0]['attributes']['rating']).to eql(anime.rating)
      end
    end
  end
  describe '#create' do
    subject { post :create }

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
      subject { post :create, params: {anime_id: anime.id} }
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
    subject { delete :destroy, params: { id: favourite.id } }
    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end
    context 'when authorized' do
      let(:favourite2) { create :favourite, user_id: user.id }
      subject { delete :destroy, params: { id: favourite2.id } }
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