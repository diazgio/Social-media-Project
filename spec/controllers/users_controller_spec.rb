require 'rails_helper'
require 'capybara/rspec'

RSpec.describe UsersController, type: :feature do
  context 'GET users controller views' do
    let(:user) { User.create(id: '1', name: 'adam', email: 'adam@test.com', password: '123456') }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    it 'Get #index' do
      visit users_path
      expect(page).to have_content('adam')
    end

    it 'Get #show' do
      visit user_path(user)
      expect(page).to have_content('Name:')
    end
  end

  context 'Testing send friend request' do
    let(:user) { User.create(id: '1', name: 'adam', email: 'adam@test.com', password: '123456') }

    before :each do
      User.create(id: '2', name: 'Pablo', email: 'pablo@test.com', password: '123456')
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    scenario 'friend request link' do
      visit users_path
      expect(page).to have_content('Add friend')
    end

    scenario 'send friend request' do
      visit users_path
      click_on 'Add friend'
      expect(page).to have_content('Friendship request was sented.')
    end
  end

  context 'Testing Accept and Reject friend requests' do
    let(:user) { User.create(id: '1', name: 'adam', email: 'adam@test.com', password: '123456') }

    before :each do
      user2 = User.create(id: '2', name: 'Pablo', email: 'pablo@test.com', password: '123456')
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      visit users_path
      click_on 'Add friend'
      click_on 'Sign out'
      visit new_user_session_path
      fill_in 'Email', with: user2.email
      fill_in 'Password', with: user2.password
      click_on 'Log in'
      visit user_path(user2)
    end

    scenario 'accept friend request' do
      click_on 'Accept Invitation'
      expect(page).to have_content('Friendship was accepted')
    end

    scenario 'Reject friend request' do
      click_on 'Reject Invitation'
      expect(page).to have_content('Friendship was rejected')
    end
  end

  context 'Testing unfriend button' do
    let(:user) { User.create(id: '1', name: 'adam', email: 'adam@test.com', password: '123456') }

    before :each do
      user2 = User.create(id: '2', name: 'Pablo', email: 'pablo@test.com', password: '123456')
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      visit users_path
      click_on 'Add friend'
      click_on 'Sign out'
      visit new_user_session_path
      fill_in 'Email', with: user2.email
      fill_in 'Password', with: user2.password
      click_on 'Log in'
      visit '/users/2'
      click_on 'Accept Invitation'
      visit '/users/2'
      click_on 'Unfriend'
      expect(page).to have_content('Friendship was rejected')
    end

    scenario 'should delete the new row with reversed attributes' do
      expect(Friendship.where(user_id: '1', friend_id: '2', confirmed: true)).to be_empty
      expect(Friendship.where(user_id: '2', friend_id: '1', confirmed: true)).to be_empty
    end
  end
end
