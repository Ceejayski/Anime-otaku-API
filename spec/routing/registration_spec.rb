require 'rails_helper'

describe 'Signup Routes' do
  it 'should route to registrations#create' do
    expect(post('/api/v1/sign_up')).to route_to(controller: 'api/v1/registrations', format: :json,
                                                action: 'create')
  end
end
