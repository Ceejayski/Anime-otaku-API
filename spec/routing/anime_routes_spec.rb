require 'rails_helper'

describe 'Anime routes' do
  it 'should route to access_tokens create action' do
    expect(get('api/v1/animes')).to route_to(controller: 'api/v1/animes', format: :json,
                                             action: 'index')
  end
  it 'should route to access_tokens create action' do
    expect(get('api/v1/animes/1')).to route_to(controller: 'api/v1/animes', format: :json,
                                             action: 'show', id: '1')
  end
end
