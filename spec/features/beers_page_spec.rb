require 'rails_helper'

include Helpers

describe "Beer" do
    before :each do
        FactoryBot.create :brewery
        FactoryBot.create :user
        FactoryBot.create :style
        sign_in(username: "Pekka", password: "Foobar1")
    end

    it "new can be created with correct inputs" do
        visit new_beer_path
        
        fill_in('beer_name', with: 'Sandels')
        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end

    it "new is not created when no name is given" do

        visit new_beer_path

        fill_in('beer_name', with: '')
        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(0)
    end
end

