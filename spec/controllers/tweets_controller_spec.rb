require 'rails_helper'

# テスト実行する時は、app/controllers/tweets_controller.rbのbefore_actionをコメントアウトすること
describe TweetsController, type: :controller do

  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested tweet to @tweet" do
      tweet = create(:tweet)
      get :edit, params: {id: tweet }
      expect(assigns(:tweet)).to eq tweet
    end

    it "renders the :edit template" do
      tweet = create(:tweet)
      get :edit, params: { id: tweet }
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it "populates an array of tweets ordered by created_at DESC" do
      tweets = create_list(:tweet, 3) 
      get :index
      expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested tweet to @tweet" do
      tweet = create(:tweet)
      get :show, params: {id: tweet }
      expect(assigns(:tweet)).to eq tweet
    end

    it "renders the :show template" do
      tweet = create(:tweet)
      get :show, params: { id: tweet }
      expect(response).to render_template :show
    end
  end

# destroyアクションのif tweet.user_id == current_user.idをコメントアウトして、テストを実行すること。
  describe 'delete #destroy' do
    it "deletes the tweet" do
      tweet = create(:tweet)
      expect{
        delete :destroy, params: { id: tweet }
      }.to change(Tweet,:count).by(-1)
    end
  end
  
# createアクションのテストが全くわからない
  describe 'POST #create' do
    it "saves the new tweets in the database" do
      expect{
        post :create, tweet: attributes_for(:tweet)
      }.to change(Tweet, :count).by(1)
    end

    it "redirects to articles#index" do
      post :create, tweet: attributes_for(:tweet)
      expect(response).to redirect_to controller: :tweets, action: :index
    end
  end

end
