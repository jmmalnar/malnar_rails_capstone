require 'rails_helper'

RSpec.feature "Mainpages", type: :feature, :js=>true do

  context "when the main page is accessed" do
    before(:each) do
      visit "/"
    end
    it "displays the index.html launch page" do
      expect(page).to have_content("Hello (from app/views/ui/index.html.erb)")
    end
    it "index page has bootstrap styling" do
      expect(page).to have_css("div.container")
    end
    it "displays the main appliation page" do
      expect(page).to have_content("Sample App (from spa-demo/pages/main.html")
    end
    it "displays the cities title" do
      expect(page).to have_content("Cities (from spa-demo/cities/cities.html")
    end
  end
end
