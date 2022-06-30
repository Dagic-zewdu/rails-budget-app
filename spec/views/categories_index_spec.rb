require 'rails_helper'

RSpec.describe 'Categories index page', type: :system do
  describe 'Content displayed by this page' do
    before(:all) do
      @user = User.create(name: 'Dagic', password: '123456', email: 'Dagic@gmail.com')
      @category = Category.create(name: 'Food', icon: 'https://picsum.photos/200', user: @user)
    end

    before(:each) do
      visit new_user_session_path
      page.fill_in 'Email', with: 'Dagic@gmail.com'
      page.fill_in 'Password', with: '123456'
      click_button 'LOG IN'
      sleep(1)
    end

    after(:all) do
      @category.destroy
      @user.destroy
    end

    it 'should shows the correct content' do
      visit categories_path
      expect(page).to have_content('Food')
      expect(page).to have_content('$0')
    end
  end
end
