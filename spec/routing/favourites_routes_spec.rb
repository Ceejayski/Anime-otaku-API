require 'rails_helper'

describe 'Favorite routes' do
  it 'should route to index action' do
    expect(get('api/v1/animes/1/favourites')).to route_to(controller: 'api/v1/favourites', format: :json,
                                             action: 'index', "anime_id"=>"1")
  end
  it 'should route to create action' do
    expect(post('api/v1/animes/1/favourites')).to route_to(controller: 'api/v1/favourites', format: :json,
                                             action: 'create', "anime_id"=>"1")
  end
  it 'should route to destroy action' do
    expect(delete('api/v1/animes/1/favourites/1')).to route_to(controller: 'api/v1/favourites', format: :json,
                                             action: 'destroy', "anime_id"=>"1", "id"=>"1")
  end
end
