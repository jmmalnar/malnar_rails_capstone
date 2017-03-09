require 'rails_helper'

describe City, type: :model do

  context "created City" do
    let(:city) { City.create(:name => "test") }

    it "will be persisted" do
      expect(city).to be_persisted
    end

    it "will have a name" do
      expect(city.name).to eq("test")
    end

    it "will be found" do
      expect(City.find(city.id)).to_not be_nil
    end

  end

  context "created City using matchers example" do
    let(:city) { City.create(:name => "test") }

    it { expect(city).to be_persisted }
    it { expect(city.name).to eq("test") }
    it { expect(City.find(city.id)).to_not be_nil }

  end

  context "created City (subject)" do
    subject { City.create(:name => "test") }

    it { is_expected.to be_persisted }
    it { expect(subject.name).to eq("test") }
    it { expect(City.find(subject.id)).to_not be_nil }

  end

  # Eagerly instantiate :before_count
  context "created City (lazy)" do
    let!(:before_count) { City.count }
    let(:city) { City.create(:name=>"test") }

    it { expect(city).to be_persisted }
    it { expect(city.name).to eq("test") }
    it { expect(City.find(city.id)).to_not be_nil }
    it { city; expect(City.count).to eq(before_count+1) }

  end

  # Here is how to skip, or make a line pending
  # x will skip
  context "created City (pending stuff)" do
    let!(:before_count) { City.count }
    let(:city) { City.create(:name=>"test") }

    xit { expect(city).to be_persisted }
    pending it { expect(city.name).to eq("test") }
    it { expect(City.find(city.id)).to_not be_nil }
    it { city; expect(City.count).to eq(before_count+1) }

  end


end