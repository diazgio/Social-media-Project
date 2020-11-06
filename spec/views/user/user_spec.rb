require 'rails_helper'

RSpec.describe 'Users' do
  before :each do
    @user1 = User.create(name: 'adam', email: 'test1@test.com', password: 123456, id: 1)
    @user2 = User.create(name: 'john', email: 'test2@test.com', password: 123456, id: 2)
    @user3 = User.create(name: 'mike', email: 'test3@test.com', password: 123456, id: 3)
    @user1.friendships.create(user_id: 1, friend_id: 2, confirmed: true)
    @user3.friendships.create(user_id: 2, friend_id: 1, confirmed: true)
  end
  feature 'User can' do
    scenario 'user can login and logout' do
      visit '/users/sign_in'
      fill_in 'Email', with: 'test1@test.com'
      fill_in 'Password', with: 123456
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
      click_on 'Sign out'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    scenario 'user have friends' do
      visit '/users/sign_in'
      fill_in 'Email', with: 'test1@test.com'
      fill_in 'Password', with: 123456
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
      click_on 'adam'
      visit '/users/1'
      expect(page).to have_content('Friends')
      
    end
    
  end
end
