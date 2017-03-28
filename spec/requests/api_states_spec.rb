require 'rails_helper'

RSpec.describe "State API", type: :request do
  include_context "db_cleanup_each"

  context "caller requests list of States" do
    it_should_behave_like "resource index", :state do
      let(:response_check) do
        expect(payload.count).to eq(resources.count)
        expect(payload.map{|f|f["name"]}).to eq(resources.map{|f|f[:name]})
        # pp "PAYLOAD GOOD!!"
      end
    end
  end

  context "a specific State exists" do
    it_should_behave_like "show resource", :state do
      let(:response_check) do
        # pp payload
        expect(payload).to have_key("id")
        expect(payload).to have_key("name")
        expect(payload["id"]).to eq(resource.id.to_s)
        expect(payload["name"]).to eq(resource.name)
      end
    end
  end

  context "create a new State" do
    it "can create with provided name"
  end

  context "existing State" do
    it "can update name"
  end
end
