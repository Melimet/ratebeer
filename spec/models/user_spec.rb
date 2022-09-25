require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  before :each do
    FactoryBot.create :style, name: "Lager", text: "yummy", id: 1
  end
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password too short" do
    user = User.create username: "Raimo", password: "Sec", password_confirmation: "Sec"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and two ratings, has the correct average rating" do
      beer = FactoryBot.create(:beer, style_id: 1)

      FactoryBot.create(:rating, beer: beer, score: 10, user: user)
      FactoryBot.create(:rating, beer: beer, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer, style_id: 1)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end
 # describe User

  describe "favorite brewery/style" do
    let(:user){ FactoryBot.create(:user) }
    ##let(:user){ FactoryBot.create(:style) }

    it "no favourite brewery if no ratings have been made" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "no favourite style if no ratings have been made" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the correct style if there are multiple styles" do
      create_beers_with_many_ratings({user: user}, 1,2,3,4,5,6,7)
      best = create_beer_with_rating({ user: user}, 50)
      
      expect(user.favorite_style).to eq("Lager")
    end
    it "is the correct brewery if there are multiple breweries" do

      create_beers_with_many_ratings({user: user}, 1,2,3,4,5,6,7)
      best = create_beer_with_rating({ user: user}, 50)
      best_brewery = Brewery.find_by id: best.brewery_id
      expect(user.favorite_brewery).to eq(best_brewery.name)
    end
  end
end