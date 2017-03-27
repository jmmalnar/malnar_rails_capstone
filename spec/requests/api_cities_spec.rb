require 'rails_helper'

RSpec.describe "City API", type: :request do
  include_context "db_cleanup_each", :transaction

  context "caller requests list of Cities" do
    let!(:cities) { (1..5).map { |idx| FactoryGirl.create(:city) } }

    it "returns all instances" do
      get cities_path, {:sample1 => "param", :sample2 => "param"},
          {"Accept" => "application/json"}
      expect(request.method).to eq("GET")
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json")
      expect(response["X-Frame-Options"]).to eq("SAMEORIGIN")

      payload=parsed_body
      expect(payload.count).to eq(cities.count)
      expect(payload.map { |f| f["name"] }).to eq(cities.map { |f| f[:name] })
    end
  end

  context "a specific City exists" do
    let(:city) { FactoryGirl.create(:city) }
    let(:bad_id) { 1234567890 }
    it "returns City when using correct ID" do
      get city_path(city.id)
      expect(response).to have_http_status(:ok)
      #pp parsed_body

      payload=parsed_body
      expect(payload).to have_key("id")
      expect(payload).to have_key("name")
      expect(payload["id"]).to eq(city.id)
      expect(payload["name"]).to eq(city.name)
    end
    it "returns not found when using incorrect ID" do
      get city_path(bad_id)
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq("application/json")

      payload=parsed_body
      expect(payload).to have_key("errors")
      expect(payload["errors"]).to have_key("full_messages")
      expect(payload["errors"]["full_messages"][0]).to include("cannot", "#{bad_id}")
    end
  end

  context "create a new City" do
    let(:city_state) {FactoryGirl.attributes_for(:city)}

    it "can create with provided name" do
      jpost cities_path, city_state
      #pp parsed_body
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json")

      # Check the payload of the response
      payload=parsed_body
      expect(payload).to have_key("id")
      expect(payload).to have_key("name")
      expect(payload["name"]).to eq(city_state[:name])
      id=payload["id"]

      # Verify we can locate the created instance in DB
      expect(City.find(id).name).to eq(city_state[:name])
    end
  end

  context "existing City" do
    it "can update name"
    it "can be deleted"
  end

end
