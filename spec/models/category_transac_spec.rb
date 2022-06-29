require 'rails_helper'

RSpec.describe CategoryTransac, type: :model do
  context 'Testing validations on a single subject' do
    before(:all) do
      @user = User.create(name: 'John Smith', password: '123456', email: 'johnsmith@gmail.com')
      @transac = Transac.create(name: 'Greengrocery', amount: 20, user: @user)
      @category = Category.create(name: 'Food', icon: 'https://picsum.photos/200', user: @user)
    end
    subject { CategoryTransac.new(category: @category, transac: @transac) }

    before { subject.save }

    after(:all) do
      @user.destroy
    end

    it 'is valid with the inserted valid attributes' do
      expect(subject).to be_valid
    end

    it 'should belong to a category' do
      subject.category = nil
      expect(subject).to_not be_valid
    end

    it 'should belong to a transaction' do
      subject.transac = nil
      expect(subject).to_not be_valid
    end
  end
end