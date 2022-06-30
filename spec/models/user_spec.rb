require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Testing validations on a single subject' do
    subject { User.new(name: 'John Smith', password: '123456', email: 'johnsmith@gmail.com') }
    before { subject.save }
    after { subject.destroy }

    it 'is valid with the inserted valid attributes' do
      expect(subject).to be_valid
    end

    it 'name must not be blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'password should have at least 6 characters' do
      subject.password = '12345'
      expect(subject).to_not be_valid
    end
  end
end
