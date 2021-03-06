require 'rails_helper'

require 'mongo'
Mongo::Logger.logger.level = ::Logger::INFO

describe State, :type => :model, :orm => :mongoid do
  # This was moved to the spec_helper.rb file
  #include Mongoid::Matchers # From mongoid-rspec gem
  include_context 'db_cleanup'

  context State do
    it { is_expected.to have_field(:name).of_type(String).with_default_value_of(nil) }
  end

  context "created State (let)" do
    let(:state) { State.create(:name => "test") }
    include_context 'db_scope'

    it { expect(state).to be_persisted }
    it { expect(state.name).to eq("test") }
    it { expect(State.find(state.id)).to_not be_nil }

  end

end
