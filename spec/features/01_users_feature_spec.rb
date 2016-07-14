require 'rails_helper'

feature 'users' do
  context 'when user is not signed in' do
    scenario 'they should see sign in and sign up links' do
      visit '/'
      expect(page).not_to have_link 'Sign Out'
    end
   
    scenario 'they should be able to sign up' do
      visit '/'
      click_link 'Sign Up'
      fill_in 'Email', with: 'wade_wilson@test.com'
      fill_in 'Password', with: 'deadpool'
      fill_in 'Password_confirmation', with: 'deadpool'
      click_button 'Sign up'

      expect(page).to have_content 'wade_wilson@test.com'
      expect(page).to have_content 'You have signed up successfully'
    end

    context 'existing user' do
      scenario 'should be able to sign in' do
        user = FactoryGirl.create(:user)

        visit '/'
        click_link 'Sign In'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content user.email
        expect(page).to have_content 'Signed in successfully'
      end
    end
  end

  context 'when user is signed in' do
    let!(:user) { FactoryGirl.create(:user) }
    before(:each) { login_as(user) }

    scenario 'they should see their name and the sign out link' do
      visit '/'

      expect(page).to have_link 'Sign Out'
      expect(page).to have_content user.email
    end

    scenario 'they should be able to sign out' do
      visit '/'
      click_link 'Sign Out'

      expect(page).to have_content 'Signed out successfully'
      expect(page).to have_link 'Sign In'
      expect(page).to have_link 'Sign Up'
      expect(page).not_to have_link 'Sign Out'
    end
  end
end
