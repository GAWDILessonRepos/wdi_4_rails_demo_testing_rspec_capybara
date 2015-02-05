require 'rails_helper'

RSpec.describe 'routes for comments' do
  it 'routes GET /articles/article.id/comments to the comments controller' do

    expect(get('/articles/1/comments/new')).to route_to(
      controller: 'comments',
      action: 'new',
      article_id: '1')
  end
end
