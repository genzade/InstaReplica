require 'rails_helper'

describe PostsController do
  it { is_expected.to use_before_action(:authenticate_user!) }
  login_user
  
  describe 'GET index' do
    before { get :index }

    it { should render_template('index') }
  end

  describe 'GET new' do
    before { get :new }

    it { should render_template 'new'}
  end
end
