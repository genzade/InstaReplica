require 'rails_helper'

feature 'users' do
  context 'when user is not signed in' do
    scenario 'they should see sign in and sign up links' do
      visit '/'
      expect(page).to have_link 'Sign In'
      expect(page).to have_link 'Sign Up'
    end
  end
end