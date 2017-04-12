require 'rails_helper'
require 'support/city_ui_helper.rb'

RSpec.feature "ManageCities", type: :feature, :js => true do
  include_context "db_cleanup_each"
  include CityUiHelper
  CITY_FORM_CSS=CityUiHelper::CITY_FORM_CSS
  #CITY_FORM_XPATH="/html/body/div/div/div/div/form"
  CITY_FORM_XPATH=CityUiHelper::CITY_FORM_XPATH
  CITY_LIST_XPATH=CityUiHelper::CITY_LIST_XPATH

  feature "view existing Cities" do
    let(:cities) { (1..5).map { FactoryGirl.create(:city) }.sort_by { |v| v["name"] } }

    scenario "when no instances exist" do
      visit root_path
      within(:xpath, CITY_LIST_XPATH) do #<== waits for ul tag
        expect(page).to have_no_css("li") #<== waits for ul li tag
        expect(page).to have_css("li", count: 0) #<== waits for ul li tag
        expect(all("ul li").size).to eq(0) #<== no wait
      end
    end

    scenario "when instances exist" do
      visit root_path if cities #need to touch collection before hitting page
      within(:xpath,CITY_LIST_XPATH) do
        expect(page).to have_css("li:nth-child(#{cities.count})") #<== waits for li(5)
        expect(page).to have_css("li", count:cities.count) #<== waits for ul li tag
        expect(all("li").size).to eq(cities.count) #<== no wait
        cities.each_with_index do |city, idx|
          expect(page).to have_css("li:nth-child(#{idx+1})", :text=>city.name)
        end
      end
    end
  end

  feature "add new City" do
    let(:city_state) { FactoryGirl.attributes_for(:city)}

    background(:each) do
      visit root_path
      expect(page).to have_css("h3", text: "Cities") #on the Cities page
      expect(page).to have_css("li", count: 0) #nothing listed
    end

    scenario "has input form" do
      expect(page).to have_css("label", :text=>"Name:")
      expect(page).to have_css("input[name='name'][ng-model='citiesVM.city.name']")
      expect(page).to have_css("button[ng-click='citiesVM.create()']", :text=>"Create a new City")
      expect(page).to have_button("Create a new City")
    end

    scenario "complete form" do
      within(:xpath, CITY_FORM_XPATH) do
        fill_in("name", :with=>city_state[:name])
        click_button("Create a new City")
      end
      within(:xpath, CITY_LIST_XPATH) do
        expect(page).to have_css("li", count:1)
        expect(page).to have_content(city_state[:name])
      end
    end

    scenario "complete form with XPath" do
      find(:xpath, "//input[@ng-model='citiesVM.city.name']").set(city_state[:name])
      find(:xpath, "//input[contains(@ng-model, 'city.name')]").set(city_state[:name])
      find(:xpath, "//button[@ng-click='citiesVM.create()']").click
      within(:xpath, CITY_LIST_XPATH) do
        expect(page).to have_xpath("//li", count:1)
        expect(page).to have_xpath("//*[text()='#{city_state[:name]}']")
      end
    end

    scenario "complete form with helper" do
      create_city city_state
      within(:xpath, CITY_LIST_XPATH) do
        expect(page).to have_css("li", count:1)
      end
    end

  end

  feature "with existing City" do
    scenario "can be updated"
    scenario "can be deleted"
  end
end
