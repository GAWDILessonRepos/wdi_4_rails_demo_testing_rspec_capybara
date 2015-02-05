require 'rails_helper'

RSpec.feature 'Managing comments' do
  scenario 'List all articles' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    Comment.create!(body:'words', article_id: article.id)
    Comment.create!(body:'words', article_id: article.id)
    Comment.create!(body:'words', article_id: article.id)

    visit "/articles/#{article.id}/comments"

    expect(page).to have_content 'Comments'
    expect(page).to have_selector 'p', count: 3
  end

  scenario 'Create an comment' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    visit "/articles/#{article.id}/comments/new"
    fill_in 'Body', with: 'So much text'
    click_on 'Create Comment'

    expect(page).to have_content(/success/i)
  end
end
