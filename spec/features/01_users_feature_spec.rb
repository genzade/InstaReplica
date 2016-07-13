require 'rails_helper'

feature 'users' do
  context 'when user is not signed in' do
    scenario 'they should see sign in and sign up links' do
      visit '/'
      expect(page).to have_link 'Sign In'
      expect(page).to have_link 'Sign Up'
    end
  end

  scenario 'they should be able to sign up' do
    visit '/'
    click_link 'Sign Up'
    fill_in :user_email, with: 'wade_wilson@test.com'
    fill_in :user_password, with: 'deadpool'
    fill_in :user_password_confirmation, with: 'deadpool'
    click_button 'Sign up'

    expect(page).to have_content 'wade_wilson@test.com'
    expect(page).to have_content 'You have signed up successfully'
  end
end