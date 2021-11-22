require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  let(:json) do
    JSON.parse(response.body)
  end
  describe '#create' do
    subject { post :create, params: params }
    context 'when invalid data provided' do
      let(:params) do
        {
          data: {
            attributes: {
              email: nil,
              password: nil,
              password_confirmation: nil,
              username: 'sirchi'
            }
          }
        }
      end
      it 'should return unprocessable_entity status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not create a user' do
        expect { subject }.not_to(change { User.count })
      end

      it 'should return error messages in response body' do
        subject
      end
    end
  end
  context 'when valid data provided' do
    let(:params) do
      {
        data: {
          attributes: {
            email: 'jsmith45',
            password: 'secretpassword',
            password_confirmation: 'secretpassword',
            username: 'sirchi'
          }
        }
      }
    end

    it 'should return 201 http status code' do
      post :create, params: params
      expect(response).to have_http_status(201)
    end
  end
end
