require 'rails_helper'
RSpec.describe Api::V1::Admin::AnimesController, type: :controller do
  describe '#index' do
    subject { get :index }
    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end

    context 'when not admin' do
      let(:user) { create :user }
      subject { get :index }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it_behaves_like 'forbidden_requests'
    end

    context 'when admin authorized' do
      let(:user) { create :user, admin: true }
      subject { get :index }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it 'when success request sent' do
        anime = create :anime, user_id: user.id
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

    context 'when not admin' do
      let(:user) { create :user }
      subject { post :create }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it_behaves_like 'forbidden_requests'
    end

    context 'when admin authorized' do
      let(:user) { create :user, admin: true }
      subject { post :create }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      context 'when invalid parameters provided' do
        let(:invalid_attributes) do
          {
            name: '',
            description: '',
            rating: '',
            genre_list: '',
            header_image: nil

          }
        end

        subject { post :create, params: invalid_attributes }

        it 'should return 422 status code' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return proper error json' do
          subject
          expect(json['errors']).to include(
            { 'status' => '422',
              'source' => { 'pointer' => '/data/attributes/name' },
              'title' => 'Unprocessable Entity',
              'detail' => "Name can't be blank",
              'code' => 'blank' },
            { 'status' => '422',
              'source' => { 'pointer' => '/data/attributes/description' },
              'title' => 'Unprocessable Entity',
              'detail' => "Description can't be blank",
              'code' => 'blank' },
            { 'status' => '422',
              'source' => { 'pointer' => '/data/attributes/rating' },
              'title' => 'Unprocessable Entity',
              'detail' => "Rating can't be blank",
              'code' => 'blank' }
          )
        end
      end
      context 'when success request sent' do
        let(:valid_attributes) do
          {
            name: 'sirchi',
            description: 'focus',
            rating: 5,
            genre_list: 'anime, scifi',
            header_image: nil

          }
        end

        subject { post :create, params: valid_attributes }

        it 'should have 201 status code' do
          subject
          expect(response).to have_http_status(:created)
        end

        it 'should have proper json body' do
          subject
          expect(json['data']['attributes']['description']).to include(
            valid_attributes[:description]
          )
        end

        it 'should create the anime' do
          expect { subject }.to change { Anime.count }.by(1)
        end
      end
    end
  end

  describe '#update' do
    let(:anime) { create :anime }
    subject { patch :update, params: { id: anime.id } }

    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end

    context 'when not admin' do
      let(:user) { create :user }
      subject { patch :update, params: { id: anime.id } }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it_behaves_like 'forbidden_requests'
    end
    context 'when admin authorized' do
      let(:user) { create :user, admin: true }
      let(:anime) { create :anime, user_id: user.id }
      subject { patch :update, params: { id: anime.id } }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      context 'when invalid parameters provided' do
        let(:invalid_attributes) do
          {

            name: '',
            description: '',
            rating: '',
            genre_list: '',
            header_image: nil

          }
        end

        subject { patch :update, params: invalid_attributes.merge(id: anime.id) }

        it 'should return 422 status code' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return proper error json' do
          subject
          expect(json['errors']).to include(
            { 'status' => '422',
              'source' => { 'pointer' => '/data/attributes/name' },
              'title' => 'Unprocessable Entity',
              'detail' => "Name can't be blank",
              'code' => 'blank' },
            { 'status' => '422',
              'source' => { 'pointer' => '/data/attributes/description' },
              'title' => 'Unprocessable Entity',
              'detail' => "Description can't be blank",
              'code' => 'blank' },
            { 'status' => '422',
              'source' => { 'pointer' => '/data/attributes/rating' },
              'title' => 'Unprocessable Entity',
              'detail' => "Rating can't be blank",
              'code' => 'blank' }
          )
        end
      end
      context 'when success request sent' do
        let(:valid_attributes) do
          {

            name: 'sirchi',
            slug: 'sirchi',
            description: 'focus',
            rating: 5,
            genre_list: 'anime, scifi',
            header_image: nil
          }
        end

        subject { patch :update, params: valid_attributes.merge(id: anime.id) }

        it 'should have 200 status code' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it 'should have proper json body' do
          subject
          expect(json['data']['attributes']['description']).to include(
            valid_attributes[:description]
          )
        end

        it 'should create the anime' do
          expect { subject }.to change { Anime.count }.by(1)
        end
      end
    end
  end

  describe '#destroy' do
    let(:user) { create :user, admin: true }
    let(:anime) { create :anime, user_id: user.id }
    subject { delete :destroy, params: { id: anime.id } }
    before do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
    end

    it 'should have 204 status code' do
      subject
      expect(response).to have_http_status(:no_content)
    end

    it 'should have empty json body' do
      subject
      expect(response.body).to be_blank
    end

    it 'should destroy the article' do
      anime
      expect { subject }.to change { user.animes.count }.by(-1)
    end
  end
end
