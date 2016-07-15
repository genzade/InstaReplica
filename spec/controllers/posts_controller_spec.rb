require 'rails_helper'

describe PostsController do
  it { is_expected.to use_before_action(:authenticate_user!) }
  login_user

  describe 'GET index' do
    let!(:post) { FactoryGirl.create(:post) }
    before { get :index }

    it { should render_template('index') }

    it 'assigns @posts' do
      expect(assigns :posts).to eq [post]
    end
  end

  describe 'GET new' do
    before { get :new }

    it { should render_template 'new'}

    it 'assigns a new Post to @post' do
      expect(assigns :post).to be_a_new(Post)
    end
  end

  describe 'POST create' do
    it 'creates a new post' do
      expect{
        post :create, post: FactoryGirl.attributes_for(:post)
      }.to change(Post, :count).by(1)
    end

    it 'redirects to the posts path' do
      post :create, post: FactoryGirl.attributes_for(:post)
      expect(response).to redirect_to posts_path
    end
  end
end
