require 'rails_helper'

describe 'Admin user routes' do
  it 'should route to access_tokens create action' do
    expect(get('api/v1/admin/users')).to route_to(controller: 'api/v1/admin/users', format: :json,
                                             action: 'index')
  end
  it 'should route to access_tokens create action' do
    expect(delete('api/v1/admin/users/1')).to route_to(controller: 'api/v1/admin/users', format: :json,
                                             action: 'destroy', id: '1')
  end
  it 'should route to access_tokens create action' do
    expect(patch('api/v1/admin/make_admin/1')).to route_to(controller: 'api/v1/admin/users', format: :json,
                                             action: 'make_admin', id: '1')
  end
  it 'should route to access_tokens create action' do
    expect(patch('api/v1/admin/remove_admin/1')).to route_to(controller: 'api/v1/admin/users', format: :json,
                                             action: 'remove_admin', id: '1')
  end
end
