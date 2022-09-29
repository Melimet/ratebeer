require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with a brewery" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_style)  {FactoryBot.create :style}

    it "is saved when it is properly created" do
      beer = Beer.create name: "Bilsneri", style:test_style, brewery: test_brewery
      expect(beer).to be_valid
    end
    it "is not saved when it has no name" do
      beer = Beer.create name: "", style:test_style, brewery: test_brewery
      expect(beer).not_to be_valid    
    end
    it "is not saved when it has no style" do
      beer = Beer.create name: "Good name", style_id: "", brewery: test_brewery
      expect(beer).not_to be_valid
    end
  end
end
