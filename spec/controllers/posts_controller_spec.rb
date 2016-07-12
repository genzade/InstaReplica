require 'rails_helper'

describe PostsController do
  describe 'GET index' do
    before { get :index }

    it { should render_template('index') }
  end
end
