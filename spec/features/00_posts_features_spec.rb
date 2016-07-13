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
        fill_in :description, with: 'the finest'
        attach_file :image, './spec/images/wilson_matt_n_peter.png'
        click_button 'Post It!'

        expect(page).to have_css 'img[src*=\'wilson_matt_n_peter.png\']'
        expect(page).to have_content 'the finest'
      end
    end
  end
end
