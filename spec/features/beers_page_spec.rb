require 'rails_helper'

include Helpers

describe "Beer" do
    before :each do
        FactoryBot.create :brewery
    end

    it "New beer can be created with correct inputs" do
        visit new_beer_path
        
        fill_in('beer_name', with: 'Sandels')
        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end

    it "New beer is not created when no name is given" do

        visit new_beer_path

        fill_in('beer_name', with: '')
        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(0)
    end
end

