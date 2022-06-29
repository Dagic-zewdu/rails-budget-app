require 'rails_helper'

RSpec.describe 'New transaction page', type: :system do
  describe 'Content displayed by this page' do
    before(:all) do
      @user = User.create(name: 'dagic', password: '123456', email: 'dagic@gmail.com')
      @category = Category.create(name: 'Food', icon: 'https://picsum.photos/200', user: @user)
    end

    before(:each) do
      visit new_user_session_path
      page.fill_in 'Email', with: 'dagic@gmail.com'
      page.fill_in 'Password', with: '123456'
      click_button 'LOG IN'
      sleep(1)
    end

    after(:all) do
      @category.destroy
      @user.destroy
    end

    it 'should show the right content' do
      visit new_transac_path
      expect(page).to have_field('Name')
      expect(page).to have_field('Amount')
      expect(page).to have_content('Food')
      expect(page).to have_selector(:link_or_button, 'ADD TRANSACTION')
    end

    it 'should shows the correct content after adding a category' do
      visit new_transac_path
      page.fill_in 'Name', with: 'Greengrocery'
      page.fill_in 'Amount', with: '20'
      find(:css, "#categories_#{@category.id}").set(true)
      sleep(3)
      click_button 'ADD TRANSACTION'
      sleep(3)
      expect(page).to have_content('Greengrocery')
      expect(page).to have_content('$20')
      expect(page).to have_content('Food')
    end
  end
end