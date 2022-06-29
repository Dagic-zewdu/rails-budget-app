require 'rails_helper'

RSpec.describe 'New category page', type: :system do
  describe 'Content displayed by this page' do
    before(:all) do
      @user = User.create(name: 'Dagic', password: '123456', email: 'Dagic@gmail.com')
    end

    before(:each) do
      visit new_user_session_path
      page.fill_in 'Email', with: 'Dagic@gmail.com'
      page.fill_in 'Password', with: '123456'
      click_button 'LOG IN'
      sleep(1)
    end

    after(:all) do
      @user.destroy
    end

    it 'should show the right content' do
      visit new_category_path
      expect(page).to have_field('Name')
      expect(page).to have_field('Icon')
      expect(page).to have_selector(:link_or_button, 'ADD CATEGORY')
    end

    it 'should shows the correct content after adding a category' do
      visit new_category_path
      page.fill_in 'Name', with: 'Food'
      page.fill_in 'Icon', with: 'https://picsum.photos/200'
      sleep(3)
      click_button 'ADD CATEGORY'
      sleep(1)
      visit categories_path
      sleep(3)
      expect(page).to have_content('Food')
      expect(page).to have_css("img[src*='https://picsum.photos/200']")
      expect(page).to have_content('$0')
    end
  end
end