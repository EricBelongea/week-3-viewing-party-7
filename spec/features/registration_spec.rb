require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'test'
    fill_in :user_password_confirmation, with: 'test'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  
  describe '#sad-path' do
    it 'does not create a user if email isnt unique' do 
      User.create(name: 'User One', email: 'notunique@example.com', password: "test")

      visit register_path
      
      fill_in :user_name, with: 'User Two'
      fill_in :user_email, with:'notunique@example.com'
      fill_in :user_password, with: 'test'
      fill_in :user_password_confirmation, with: 'test'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email has already been taken")
    end

    it 'Passwords must match' do
        visit register_path
      
        fill_in :user_name, with: 'User Two'
        fill_in :user_email, with:'notunique@example.com'
        fill_in :user_password, with: 'test'
        fill_in :user_password_confirmation, with: 'not it foo'
        click_button 'Create New User'

        expect(current_path).to eq(register_path)
        expect(page).to have_content("Passwords must match")
      end
    end
end
