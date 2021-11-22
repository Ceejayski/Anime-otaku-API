require 'rails_helper'
require 'json'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  describe 'Authenticate' do
    let(:user) do
      User.create(username: 'jsmith', password: 'secret', password_confirmation: 'secret', email: 'my@email.com')
    end
    let(:json) do
      JSON.parse(response.body)
    end

    context 'when no params_data is provided' do
      subject { post :authenticate }
      it_behaves_like 'unauthorised_request'
    end

    it 'when email is wrong the user email' do
      post :authenticate, params: { email: 'invalid', password: 'useremailword' }
      expect(response).to have_http_status(401)
      expect(json['error']['user_authentication']).to include('invalid credentials')
    end

    it 'when user password is wrong' do
      post :authenticate, params: { email: user.email, password: 'none' }
      expect(response).to have_http_status(401)
      expect(json['error']['user_authentication']).to include('invalid credentials')
    end

    it 'Succesfully authenticate user' do
      post :authenticate, params: { email: user.email, password: user.password }
      expect(response).to have_http_status(200)
      expect(json).to have_key('auth_token')
    end
  end
end
