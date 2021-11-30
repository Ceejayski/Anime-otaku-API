require 'rails_helper'

describe 'Authentication routes' do
  it 'should route to access_tokens create action' do
    expect(post('api/v1/login')).to route_to(controller: 'api/v1/authentication', format: :json,
                                             action: 'authenticate')
  end
end
