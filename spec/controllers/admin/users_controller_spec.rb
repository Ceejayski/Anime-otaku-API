require 'rails_helper'
RSpec.describe Api::V1::Admin::UsersController, type: :controller do
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
      let(:anime) { create :anime }
      subject { get :index }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it 'when success request sent' do
        create_list :user, 5
        users = User.all
        subject
        expect(response).to have_http_status(:ok)
        expect(json['data'][0]['attributes']['email']).to eql(users[1].email)
      end
    end
  end

  describe '#make_admin' do
    let(:user) { create :user }
    subject { patch :make_admin, params: { id: user.id } }
    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end

    context 'when not admin' do
      let(:user2) { create :user }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user2)
      end

      it_behaves_like 'forbidden_requests'
    end
    context 'when admin authorized' do
      let(:user3) { create :user, admin: true }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user3)
      end
      subject { patch :make_admin, params: { id: user.id } }

      it 'when success request sent' do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context 'when admin authorized and params user is already admin' do
      let(:user3) { create :user, admin: true }
      let(:user4) { create :user, admin: true }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user3)
      end
      subject { patch :make_admin, params: { id: user4.id } }

      it 'when success request sent' do
        subject
        expect(response).to have_http_status(404)
      end
    end

    describe '#remove_admin' do
      let(:user) { create :user }
      subject { patch :remove_admin, params: { id: user.id } }
      context 'when no code provided' do
        it_behaves_like 'forbidden_requests'
      end

      context 'when invalid code provided' do
        before { request.headers['authorization'] = 'Invalid token' }
        it_behaves_like 'forbidden_requests'
      end

      context 'when not admin' do
        let(:user2) { create :user }
        before do
          allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user2)
        end

        it_behaves_like 'forbidden_requests'
      end
      context 'when admin authorized is not an admin' do
        let(:user3) { create :user, admin: true }
        before do
          allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user3)
        end
        subject { patch :remove_admin, params: { id: user.id } }

        it 'when success request sent' do
          subject
          expect(response).to have_http_status(404)
        end
      end

      context 'when admin authorized and params user is already admin' do
        let(:user3) { create :user, admin: true }
        let(:user4) { create :user, admin: true }
        before do
          allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user3)
        end
        subject { patch :remove_admin, params: { id: user4.id } }

        it 'when success request sent' do
          subject
          expect(response).to have_http_status(:created)
        end
      end
    end

    describe '#destroy' do
      let(:user) { create :user, admin: true }
      let(:user2) { create :user, admin: true }
      let(:user23) { create :user }
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end
      subject { delete :destroy, params: { id: user2.id } }

      it 'should fail if user tries to delete current user' do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(403)
      end

      it 'should fail if user tries to delete admin user' do
        subject
        expect(response).to have_http_status(403)
      end

      context 'when success request sent' do
        subject { delete :destroy, params: { id: user23.id } }
        it 'should pass' do
          expect(response.body).to be_blank
        end
      end
    end
  end
end
