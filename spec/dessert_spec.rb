require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) do 
    Dessert.new("apples",10,chef)
  end

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("apples")
    end

    it "sets a quantity" do 
      expect(dessert.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect do
        subject(:dessert) { Dessert.new("apples", "brownies", chef) }
      end.to raise_error(ArgumentError)
    end 
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      dessert.add_ingredient("cake")
      expect(dessert.ingredients).to include("cake")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      dessert.add_ingredient("cake")
      dessert.add_ingredient("chocolate")
      dessert.add_ingredient("ice cream")
      dessert.add_ingredient("churro")
      expect(dessert.ingredients).to eq(["cake","chocolate","ice cream","churro"])
      dessert.mix!
      expect(dessert.ingredients).to_not eq(["cake","chocolate","ice cream","churro"])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do 
      expect(dessert.eat(2)).to eq(8)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{ dessert.eat(11) }.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    let(:chef) { double(:titleize => "Chef Arnold the Great Baker")}
    it "contains the titleized version of the chef's name" do 
      expect( dessert.serve).to eq("Chef Arnold the Great Baker has made 10 apples!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do 
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
