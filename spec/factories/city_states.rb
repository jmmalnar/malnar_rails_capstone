FactoryGirl.define do

  ##### CITY Factories
  factory :city_fixed, class: 'City' do
    name 'test'
  end

  factory :city_sequence, class: 'City' do
    sequence(:name) { |n| "test#{n}" }
  end

  factory :city_names, class: 'City' do
    sequence(:name) { |n| ["larry", "moe", "curly"][n%3] }
  end

  factory :city_transient, class: 'City' do
    transient do
      large true
    end

    after(:build) do |object, props|
      object.name = props.large ? "Large City" : "Small City"
    end
  end

  # For an immutable object
  factory :city_ctor, class: 'City' do
    transient do
      hash {}
    end
    initialize_with { City.new(hash) }
  end

  factory :city_faker, class: 'City' do
    name {Faker::Address.city}
  end

  factory :city, :parent => :city_faker do
  end

  ##### STATE Factories
  factory :state, class: 'State' do
    name { Faker::Address.state}
  end

end