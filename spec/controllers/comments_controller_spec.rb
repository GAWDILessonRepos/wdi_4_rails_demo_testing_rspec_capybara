require 'rails_helper'


RSpec.describe CommentsController do

  let(:valid_attributes) {
    { body: "You won't" }
  }

  let(:invalid_attributes) {
    { body: nil }
  }

  describe 'GET index' do
    it 'assigns @comments' do
      article = Article.create!(title: "Words", body: "even more words")
      comments =Comment.all
      get :index, article_id: article.id
      expect(assigns(:comments)).to eq comments
    end
  end
  describe 'GET new' do
    it 'assigns @article' do
      article = Article.create!(title:'Words Words Words', body:'more words')
      params = {article_id: article.id}
      get :new, params
      expect(assigns(:article)).to eq article
    end
    it 'assigns @comment' do
      article = Article.create!(title: "Words", body: "even more words")
      get :new, article_id: article.id
      expect(assigns(:comment)).to be_a_new Comment
    end
  end
  describe 'POST create' do
    context 'valid' do
      it 'saves a new article' do
        article = Article.create!(title: "Words", body: "even more words")
        expect {
          post :create, comment: valid_attributes, article_id: article.id
        }.to change(Comment, :count).by 1
      end
      it 'assigns @comment' do
        article = Article.create!(title: "Words", body: "even more words")
        post :create, comment: valid_attributes, article_id: article.id
        expect(assigns(:comment)).to be_a Comment
        expect(assigns(:comment)).to be_persisted
      end
      it 'redirects to the created comment' do
        article = Article.create!(title: "Words", body: "even more words")
        post :create, comment: valid_attributes, article_id: article.id
        expect(response).to redirect_to article_comments_path(article)
      end
    end
    context 'invalid' do
      it 'assigns @comment, but does not save a new comment' do
        article = Article.create!(title: "Words", body: "even more words")
        post :create, comment: invalid_attributes, article_id: article.id
        expect(assigns(:comment)).to be_a_new Comment
      end

      it 're-renders the new template' do
        article = Article.create!(title: "Words", body: "even more words")
        post :create, comment: invalid_attributes, article_id: article.id
        expect(response).to render_template 'new'
      end
    end
  end
end
