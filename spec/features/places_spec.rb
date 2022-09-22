require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if multiple bars are returned by the API, they all show up on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), 
        Place.new( name: "Kumpulan piilopullo", id: 2 ),
        Place.new( name: "Alko Arabia", id: 3 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kumpulan piilopullo"
    expect(page).to have_content "Alko Arabia"
  end
  it "if no bars are returned byt the API, nothing will show up" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in"
  end

end