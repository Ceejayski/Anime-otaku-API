require 'rails_helper'
RSpec.describe Api::V1::UserFavouritesController, type: :controller do
  let(:user) { create :user }
  describe '#index' do
    subject { get :index, params: { user_id: user.id} }

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
      let(:favourite) { create :favourite, user_id: user.id, anime_id: anime.id }
      subject { get :index, params: { user_id: user.id} }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it 'when success request sent' do
        favourite
        subject
        expect(response).to have_http_status(:ok)
        expect(json['data'][0]['attributes']['rating']).to eql(anime.rating)
      end
    end
  end
end