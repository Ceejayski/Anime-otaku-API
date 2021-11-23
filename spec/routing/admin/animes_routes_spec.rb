require 'rails_helper'

describe 'Admin user routes' do
  it 'should route to access_tokens create action' do
    expect(get('api/v1/admin/animes')).to route_to(controller: 'api/v1/admin/animes', format: :json,
                                             action: 'index')
  end
  it 'should route to access_tokens create action' do
    expect(post('api/v1/admin/animes')).to route_to(controller: 'api/v1/admin/animes', format: :json,
                                             action: 'create')
  end
  it 'should route to access_tokens create action' do
    expect(patch('api/v1/admin/animes/1')).to route_to(controller: 'api/v1/admin/animes', format: :json,
                                             action: 'update', id: '1')
  end
  it 'should route to access_tokens create action' do
    expect(delete('api/v1/admin/animes/1')).to route_to(controller: 'api/v1/admin/animes', format: :json,
                                             action: 'destroy', id: '1')
  end
end
