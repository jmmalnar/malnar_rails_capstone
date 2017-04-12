module CityUiHelper
  CITY_FORM_CSS="body > div > div > div > div > form"
  #CITY_FORM_XPATH="/html/body/div/div/div/div/form"
  CITY_FORM_XPATH="//h3[text()='Cities']/../form"
  CITY_LIST_XPATH="//h3[text()='Cities']/../ul"

  def create_city city_state
    visit root_path unless page.has_css?("h3", text:"Cities")
    expect(page).to have_css("h3", text:"Cities") #on the Cities page
    within(:xpath, CITY_FORM_XPATH) do
      fill_in("name", :with=>city_state[:name])
      click_button("Create a new City")
    end
    within(:xpath, CITY_LIST_XPATH) do
      expect(page).to have_css("li a", :text=>city_state[:name])
    end
  end

  def update_city existing_name, new_name

  end

  def delete_city name

  end
end