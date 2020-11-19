require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(:name => "Transportation") 
      @product = Product.new(
        :name =>        "Hoverboard", 
        :price_cents => "8675309", 
        :quantity =>    "5", 
        :category =>    @category
      )
     
      
    end 

    it "is valid with a name, price, quantity, and category" do
      expect(@product).to be_valid
    end

    it "is not valid with out a name" do
      @product = Product.new(name: nil, price_cents: @price, quantity: @quantity, category: @category) 
      expect(@product).to_not be_valid
    end

    it "is not valid with out a price" do
      @product = Product.new(name: @name, price_cents: nil, quantity: @quantity, category: @category) 
      expect(@product).to_not be_valid
    end

    it "is not valid with out a quantity" do
      @product = Product.new(name: @name, price_cents: @price, quantity: nil, category: @category) 
      expect(@product).to_not be_valid
    end

    it "is not valid with out a category" do
      @product = Product.new(name: @name, price_cents: @price, quantity: @quantity, category: nil) 
      expect(@product).to_not be_valid
    end
  end
end
