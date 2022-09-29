require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style) {FactoryBot.create :style, name: "Lager", text: "yummy"}
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery, style:style}
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery, style:style }
  let!(:user) { FactoryBot.create :user }

  before :each do
   
    sign_in(username:"Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "all given show up" do
    
    create_beers_with_many_ratings({user: user}, 5 , 5, 5)
    visit ratings_path

    expect(page).to have_content "Total ratings: #{Rating.count}"
  end

  it "correct ones show up on user's page" do

    create_beers_with_many_ratings({user: user}, 5 , 5, 5, 5)
    user2 = FactoryBot.create :user, username: "Seppo"
    create_beers_with_many_ratings({user: user2}, 6 , 6, 6)

    visit user_path(user2)
    
    expect(page).to have_content "Has left #{user2.ratings.count}"
  
  end

  it "rating is deleted correctly" do
    create_beers_with_many_ratings({user: user}, 5 , 5, 5, 5)
    visit user_path(user)

    first_rating_by_user = Rating.find_by user_id: user.id
   
    expect{
      click_link(href: "/ratings/#{first_rating_by_user.id.to_s}")
    }.to change{Rating.count}.by(-1)
  end

  it "correct favorite brewery is shown to user" do

    create_beers_with_many_ratings({user: user}, 5 , 5, 5, 5)
    visit user_path(user)

    expect(page).to have_content "Favourite brewery: anonymous"
  end

  it "correct favorite style is shown to user" do
    
    create_beers_with_many_ratings({user: user}, 5 , 5, 5, 5)
    visit user_path(user)

    expect(page).to have_content "Favourite style: Lager"
  end

end