require "rails_helper"

RSpec.describe "User Login" do
  before(:each) do

  end

  describe '#Happy-Path' do
    it 'user can login with proper creds' do
      user = User.create!(name: "Ricky Bobby", email: "babyjesus@gmail.com", password: "Winning")

      visit root_path

      expect(page).to have_button("Login")
      click_button("Login")

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button("Login")

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Welcome, #{user.name}")
    end
  end

  describe '#Sad-Path' do
    it 'Mismatched PASSWORD returns to login page' do
      user = User.create!(name: "Ricky Bobby", email: "babyjesus@gmail.com", password: "Winning")

      visit root_path

      expect(page).to have_button("Login")
      click_button("Login")

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: "Not1sturLast"
      click_button("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Try Again :(")
    end

    it "Non-existant email?" do
      user = User.create!(name: "Ricky Bobby", email: "babyjesus@gmail.com", password: "Winning")

      visit root_path

      expect(page).to have_button("Login")
      click_button("Login")

      expect(current_path).to eq(login_path)

      fill_in :email, with: "not an email"
      fill_in :password, with: user.password
      click_button("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid email")
    end
  end
end