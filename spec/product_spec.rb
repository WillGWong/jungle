require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.new(name: "Cat1")
      cat1 = Category.find_or_create_by! name: 'Cat1'
      subject = cat1.products.create!({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      })
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      @category = Category.new(name: "Cat1")
      cat1 = Category.find_or_create_by! name: 'Cat1'
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a price" do
      @category = Category.new(name: "Cat1")
      cat1 = Category.find_or_create_by! name: 'Cat1'
      subject.price = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a quantity" do
      @category = Category.new(name: "Cat1")
      cat1 = Category.find_or_create_by! name: 'Cat1'
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a category" do
      @category = Category.new(name: "Cat1")
      cat1 = Category.find_or_create_by! name: 'Cat1'
      subject.category = nil
      expect(subject).to_not be_valid
    end

  end
end