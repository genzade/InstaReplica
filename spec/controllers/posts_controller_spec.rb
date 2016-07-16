require 'rails_helper'

describe PostsController do
  it { is_expected.to use_before_action(:authenticate_user!) }

  describe 'GET index' do
    let!(:post) { FactoryGirl.create(:post) }
    before { get :index }

    it { should render_template('index') }

    it 'assigns @posts' do
      expect(assigns :posts).to eq [post]
    end
  end

  describe 'GET new' do
    login_user
    before { get :new }

    it { should render_template 'new'}

    it 'assigns a new Post to @post' do
      expect(assigns :post).to be_a_new(Post)
    end
  end

  describe 'POST create' do
    login_user
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

  describe 'DELETE #destroy' do
    context 'with valid user' do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:post) { FactoryGirl.create(:post, user: user) }
      before(:each) { sign_in user }

      it 'deletes the post' do
        expect do
          delete :destroy, id: post
        end.to change(Post, :count).by(-1)
      end

      it do
        delete :destroy, id: post
        is_expected.to set_flash[:success].to 'Post deleted successfully'
      end

      it 'redirects to posts path' do
        delete :destroy, id: post
        expect(response).to redirect_to posts_path
      end
    end
  end
end
