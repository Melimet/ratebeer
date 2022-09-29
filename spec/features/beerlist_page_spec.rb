require 'rails_helper'

describe "Beerlist page" do
    before :all do
    Capybara.register_driver :chrome do |app|
        Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end

    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
    end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "A Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "B Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "C Ayinger")
    @style1 = Style.create name: "A Lager"
    @style2 = Style.create name: "B Rauchbier"
    @style3 = Style.create name: "C Weizen"
    @beer1 = FactoryBot.create(:beer, name: "A Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "B Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "C Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')

    expect(page).to have_content "A Nikolai"
  end

  it "orders correctly by name", js:true do
    visit beerlist_path
    
    find('#beertable').first('tablerow')

    expect(page).to have_content "A Nikolai"
  end

  it "orders correctly by style", js:true do
    visit beerlist_path

    click_button "Style"

    find('#beertable').first('tablerow')
    expect(page).to have_content "A Lager"
  end

  it "orders correctly by brewery", js:true do
    visit beerlist_path

    click_button "Brewery"

    find('beertable').first("tablerow")
    expect(page).to have_content "A Koff"
  end
end