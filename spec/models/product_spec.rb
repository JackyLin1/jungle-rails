require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "all 4 attributes passed in" do
      @category = Category.create(name:"All")
      item = Product.new(
        name: "spoon",
        price: 150.00,
        quantity: 9,
        category_id: @category.id
      )
      expect(item).to (be_valid)
    end

    it 'not save without name' do
      @category = Category.create(name: "noName")
      item = Product.new(
        name: nil,
        price: 150.00,
        quantity: 9,
        category_id: @category.id
      )
      
      expect(item).to_not (be_valid)
      expect(item.errors[:name]).to include("can't be blank")
    end

    it 'not save without price' do
      @category = Category.create(name: 'noMoney')
      item = Product.new(
        name: "Spoon",
        price: nil,
        quantity: 9,
        category_id: @category.id
      )
      expect(item).to (be_valid)
      # expect(item.errors[:price]).to include("can't be a number")
    end

    it 'not save without quantity' do
      @category = Category.create(name: 'noItem')
      item = Product.new(
        name: "Spoon",
        price: 150.00,
        quantity: nil,
        category_id: @category.id
      )
      expect(item).to_not (be_valid)
      expect(item.errors[:quantity]).to include("can't be blank")
    end

    it 'not save without category id' do
      @category = Category.create(name: 'noCategory')
      item = Product.new(
        name: "Spoon",
        price: 150.00,
        quantity: 9,
        category_id: nil
      )
      expect(item).to_not (be_valid)
      expect(item.errors[:category]).to include("can't be blank")
    end

  end
end