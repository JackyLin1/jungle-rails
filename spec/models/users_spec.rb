require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'all 4 attributes passed in' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: '12345'
      )
      expect(user).to (be_valid)
    end

    it 'should not pass without email' do
      user = User.create(
        name: 'Test',
        email: nil,
        password: '12345',
        password_confirmation: '12345'
      )
      expect(user).to_not (be_valid)
    end

    it 'should not pass without password' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: nil,
        password_confirmation: '12345'
      )
      expect(user).to_not (be_valid)
    end

    it 'should not pass with a password less than 5 characters' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '1234',
        password_confirmation: '1234'
      )
      expect(user).to_not (be_valid)
    end

    it 'should not pass with different password_confirmation' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: '678910'
      )
      expect(user).to_not (be_valid)
    end

    it 'should not pass without password_confirmation' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: nil
      )
      expect(user).to_not (be_valid)
    end

    it 'should not pass with existing email' do
      user1 = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: '12345'
      )
      user2 = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '23456',
        password_confirmation: '23456'
      )
      expect(user2).to_not (be_valid)
    end
  end


  describe 'credentials' do

    it 'should authenticate a user' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: '12345'
      )
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end 

    it 'should authenticate a with extra space in email' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: '12345'
      )
      emailWithExtraSpaces = '  123@mail.com      '
      expect(User.authenticate_with_credentials(emailWithExtraSpaces, user.password)).to eq(user)
    end 

    it 'should authenticate a with different casing in email' do
      user = User.create(
        name: 'Test',
        email: '123@mail.com',
        password: '12345',
        password_confirmation: '12345'
      )
      emailWithDifCasing = '123@MAIl.CoM'
      expect(User.authenticate_with_credentials(emailWithDifCasing , user.password)).to eq(user)
    end 
  end
end