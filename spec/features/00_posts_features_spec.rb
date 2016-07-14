require 'rails_helper'

feature 'posts' do
  context 'no posts have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add a post'
    end
  end

  context 'creating a post' do
    context 'signed in user' do
      before(:each) do
        user = FactoryGirl.create(:user) ; login_as(user)  
      end

      scenario 'can create a new post' do
        visit '/posts'
        click_link 'Add a post'
        attach_file :post_image, './spec/images/wilson_matt_n_peter.png'
        fill_in :post_caption, with: 'the finest'
        click_button 'Create Post'

        expect(current_path).to eq posts_path
        expect(page).to have_css 'img[src*=\'wilson_matt_n_peter.png\']'
        expect(page).to have_content 'the finest'
      end
    end
  end

  context 'when not signed in' do
    scenario 'cannot create a post' do
      visit '/posts'
      click_link 'Add a post'
      
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'You need to sign in or sign up'
    end
  end
end
